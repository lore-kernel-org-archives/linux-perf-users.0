Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A21214A4F7;
	Wed, 25 Sep 2024 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727304054; cv=none; b=c4tOuoWLo3tie4vJF83UmNsGRuS2yvAUkfYK8fFuSZV++Sy8vYuyzXYkGZmMAHS3IOqN8AXQXp2jsOv5eRFk3v6gT2YWP2Gm4QWnM4HpLpXNEhfO914H/3hqzFzyklpsGy02Eko+CHiHcObngYZDlxP9l2bVUdDxabeApAMj0e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727304054; c=relaxed/simple;
	bh=68EeAkuIjw8YFq+hJ4Srg5xsBshd3CLmVechItMjgwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tea1GNnUSBq1tUy3KoxxIXORp2zVyc3f6NTsWEkJ4FXPS6RdTg9k6pCtkCEq1fwaxUDhvSO2AkmUvjyYOf9eXqnlMpyFfaRZXWreG1fBbkUSttlAtM/NvAmzHZj8GSP4/0JN0Gqf1UA3iuJCvSw4t6DVzcjKbEnPwcSUqJ3SGVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsYqq0Dh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsYqq0Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A954C4CEC3;
	Wed, 25 Sep 2024 22:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727304054;
	bh=68EeAkuIjw8YFq+hJ4Srg5xsBshd3CLmVechItMjgwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsYqq0Dh7LMIHz3pOxxCvRX5FcUYASltk9jhkJD3+hqHtPqe5Rv8E9iNTVQdmWmsj
	 RHEKf+rWFsEjCRBvfSF5sIDkzpLyEA/OfcNpCj9VTOUvU1iNTIjYimKQ7nSBbga3JY
	 GwDoO0XSq/B75Mp5EFr3zvN5Ces1xdLDgpqMLN9TscgSnyU21ql5WsscW4npl41NZy
	 NIIO7wvXP6Ols+jGaYKDJpF80Wkoty7nFaHhRw6cy5h9/AmwmG61vIvAMr7uJZCA/v
	 WfGz+5/rf8A8UtJUdiJcd2onhLuydXACenHyV/FSP20ODTblOQmIoRdRodvEYn8eAu
	 r8+XLLJ+LZhvw==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com,
	James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] perf: cs-etm: Coresight decode and disassembly improvements
Date: Wed, 25 Sep 2024 15:40:51 -0700
Message-ID: <172730392640.3246951.12111888445468936288.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
References: <20240916135743.1490403-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 16 Sep 2024 14:57:31 +0100, James Clark wrote:

> A set of changes that came out of the issues reported here [1].
> 
>  * First 2 patches fix a decode bug in Perf and add support for new
>    consistency checks in OpenCSD
>  * The remaining ones make the disassembly script easier to test
>    and use. This also involves adding a new Python binding to
>    Perf to get a config value (perf_config_get())
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
