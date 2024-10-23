Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16313137776;
	Wed, 23 Oct 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706421; cv=none; b=bbHNjI6pirUcvRtPwO8mBUFkTkWsgJSWgPdXwb3uvIIaCX3qTntLr369Bwt5VYsFHnluuvc4f0mH+HErXBuCnO/WTR1xRnC79ljUzOv+BtKSK1dkbxMMcvdnwVmlNBLtiYKILqKv50hBc+xAEHJZeP0To6ZtMmpc9vFXwPorOeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706421; c=relaxed/simple;
	bh=NHCfiBqL3e7BAY9HX4hxpEblYY8yvQhUCNOqPDOFPto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kymDCB2Ez5UFZJK2hWTutnqUDc3u9zWOFMyafsNIaoH+7OWj95qDSR/X3vIkyrHz8s4EunkcpDRzaIYyQNxEwfUU0ndJG1erwyK49C67IBHNCf4kIxyPSanaWjMsmZubTdDEKd0Qi8/6GmWCHw2DJoD87w2x77PNt555FCFbyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZstdBQNK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZstdBQNK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC15C4CECD;
	Wed, 23 Oct 2024 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729706420;
	bh=NHCfiBqL3e7BAY9HX4hxpEblYY8yvQhUCNOqPDOFPto=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZstdBQNKznlJytZGiQI8dNQvZL/3TafU6iiK3QExTNNppOlozz4k6mceFMLKGbnsC
	 7rxTBQS4z5E/pzrCqGHoT/+gsak2cE92cNzbA9KW7r+y01hrOBJ6O1chHWi8F5NLoA
	 +oCFmN5jYOkK9FV6sJqBr91Cf2FY1JY/Ba6nXcxH9hi7IatZnSM7abdtgDysjc7ohy
	 siIYIcn6fZBjdDES8hQfus37Xhwg7ktHHal3WJO/vvh/XTk87aLAgH7/eJVegLZpWK
	 QPJ/hqMoLt6uryqiCwiRf2x++AWVyERdbybdXKrfoOCdgm6G9LA6KKwKh2VtFo0AuF
	 QuzFWVkAcNzKQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, 
 James Clark <james.clark@linaro.org>
In-Reply-To: <20241020021842.1752770-1-acme@kernel.org>
References: <20241020021842.1752770-1-acme@kernel.org>
Subject: Re: [PATCH 0/3 v3] Expose the 'perf test -w' workloads
 functionality
Message-Id: <172970642028.1242473.4878778833467222484.b4-ty@kernel.org>
Date: Wed, 23 Oct 2024 11:00:20 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Sat, 19 Oct 2024 23:18:39 -0300, Arnaldo Carvalho de Melo wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Hi,
> 
>         I noticed that the 'perf test -w' code wasn't well exposed, so
> add a '--list-workloads' option to list the existing workloads and document it
> in the 'perf test' man page.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

