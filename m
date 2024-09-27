Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EE1C1AAF;
	Fri, 27 Sep 2024 16:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727456355; cv=none; b=Cfmri3eDRiv0Xzm1kUyV3pGb3I0U95m6X3rzSjfzBv9NtDpisNMOZSFt+UCQXdGqSSqERHzOuMugOls6ZNu8VcogYOY2eouX0s54GkO4HkCxKak19/uE5IwovjeXV8UyzB8JyuwMqmufJdffP/Ur+WavjqaXJkhlGdGUlXxUl+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727456355; c=relaxed/simple;
	bh=EuZonBqqjqcSbr51Oyo1rahNDX707MFQqkmKdafHKes=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tB2AvBisu0Fk8DJYQsFbZ9JdUCvg4C02uSKNUDCoamnD4/F4sgsnWCS2BuJuBBYHM7uvFeNWCe5zAT811P3NQwVdHIYJjd1bRxAtVMPzflJZPK/3yaWdCLjg+JrzmL/ViwMpGTweXdHrFnWbh/sLL/Dq2s13vmrlTmwBlrwF6d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDlXOkjb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDlXOkjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E37AC4CEC4;
	Fri, 27 Sep 2024 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727456354;
	bh=EuZonBqqjqcSbr51Oyo1rahNDX707MFQqkmKdafHKes=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=SDlXOkjb3iukz4N8cAA5jon6CJjcfEGpYpjJqe2JEGcVo2vwoKpU/Al+bamKTwhHs
	 6dinyw2U6xT9SP1y+6inskMSTHW+kyDCC0W/CUvC1L31782smzEt/fFq+WP8A8gMAy
	 c4tuKy491KQmN1c2USsstISkOdoChQn0DKfyNGrJgQlQMDh3TMtgAhSsOp+0hGa+u+
	 1MLD5H5EdF/VNwJtHTkK6dtvCOtQKs69BO9nIEmy2PiggMDM44Nwsa3YwKqtRBoV18
	 y+Z+P5IbHVx5a7qbpFgMHkm8wHr/5HWQk+TGgMrIZp25DjGgI79m5uMZdB2ok43PU9
	 vajKTufUbcU3A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v1] perf test: Ignore security failures in all PMU test
Date: Fri, 27 Sep 2024 09:59:10 -0700
Message-ID: <172745629958.248053.5554393032064276229.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20240925173013.12789-1-irogers@google.com>
References: <20240925173013.12789-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 25 Sep 2024 10:30:13 -0700, Ian Rogers wrote:

> Refactor code to have some more error diagnosis on traps, etc. and to
> do less work on each line. Add an ignore situation for security failures.
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
