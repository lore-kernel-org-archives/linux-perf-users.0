Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31541B94F
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Jun 2024 19:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719602889; cv=none; b=kdw0JY5BjaH7KBDYJug4ekwolxFsylvzJCaumEfvgsjT4slOc7u0VIkY4q0Alerg1uP4QnkgAghzikfpoDB/zNKUQ2bunVEd5the9dpPMzL5onWrHN6KtDyWot9Ep7vAODuFUxuSI7K1aw3EA8P8qETfvQcmUevEZMYqUp8cDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719602889; c=relaxed/simple;
	bh=JIHdNoWNNe8lhXbmiwDx+eNXYzr3/G6ldRPHctL5TEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1D3s0DChGbFsPXLuFqYXnbZ3KpMKYsS2EqqxSYSju/+/JUvc/32PeYI6yA3Hou46tP1atCJcpQy5ExkarJhCmryR59EomfQx5X+Z05uyW5ji2Ui0sUQoj81HlyVZ1D89lTGQS36VVgzKXI38FcMX6SviozRq7MfqRWRpDhOTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXS/kVKD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXS/kVKD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43AADC116B1;
	Fri, 28 Jun 2024 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719602888;
	bh=JIHdNoWNNe8lhXbmiwDx+eNXYzr3/G6ldRPHctL5TEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SXS/kVKDTBlxZJORnDPN+8q3zFYElRqZkwBuLBcGRR8IIL5o5TU9yiaLpYsb1r9XJ
	 WAHLdJAvwKqT9CGPRCkS9w6PrMiI/OabNg4xGcMNNVoJBAcmvQWes2A3cDOfgfeF+K
	 gXHwek/89boXOCv+EHSki/TNlgUDbiUnugwJPg5RwU+sVTUZD/ba/DxhYgwKCc8qiU
	 9XDqBuoByfM6fYxEHI7guk6JKLyT1ZOqK+qDoVavVDkVrqnCeRLiWfoyIkWdIHLxkK
	 Z7ctxFLI3gLrSxoMYRVogU1S7oyuJ4k5jty22c37GssRJTrIGBVQKouO5Jj4/KK6ap
	 Q29aK7Rqfs4Gg==
Date: Fri, 28 Jun 2024 16:28:06 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Aditya Gupta <adityag@linux.ibm.com>, jolsa@kernel.org,
	irogers@google.com, linux-perf-users@vger.kernel.org,
	maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com,
	kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com
Subject: Re: [PATCH v11 1/4] perf check: introduce check subcommand
Message-ID: <Zn8OxjRgFlPduRKh@x1>
References: <20240627100644.772219-1-adityag@linux.ibm.com>
 <20240627100644.772219-2-adityag@linux.ibm.com>
 <Zn7EvDbsnlbLXj4g@x1>
 <Zn7FmltYgUzi6YvV@x1>
 <Zn7GsEKwLxn5bMyN@x1>
 <Zn7HtaJb3NL2k5YG@x1>
 <Zn8AvuvyjXFGa90c@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn8AvuvyjXFGa90c@google.com>

On Fri, Jun 28, 2024 at 11:28:14AM -0700, Namhyung Kim wrote:
> On Fri, Jun 28, 2024 at 11:24:53AM -0300, Arnaldo Carvalho de Melo wrote:
> 
> > And while looking at it:
> > 
> >              get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
> > 
> > This looks wrong, no? Or at least confusing, have to check the source
> > code...
> 
> We have this in Makefile.config
> 
> ifndef NO_AUXTRACE
>   ifeq ($(SRCARCH),x86)
>     ifeq ($(feature-get_cpuid), 0)
>       $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
>       NO_AUXTRACE := 1
>     endif
>   endif

The complete sequence is:

ifndef NO_AUXTRACE
  ifeq ($(SRCARCH),x86)
    ifeq ($(feature-get_cpuid), 0)
      $(warning Your gcc lacks the __get_cpuid() builtin, disables support for auxtrace/Intel PT, please install a newer gcc)
      NO_AUXTRACE := 1
    endif
  endif
  ifndef NO_AUXTRACE
    $(call detected,CONFIG_AUXTRACE)
    CFLAGS += -DHAVE_AUXTRACE_SUPPORT
    ifeq ($(feature-reallocarray), 0)
      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
    endif
  endif
endif

The most descriptive would be to HAVE_GET_CPUID_SUPPORT and have it used
in the source code.

That or have:

diff --git a/tools/perf/builtin-check.c b/tools/perf/builtin-check.c
index 44ffde6f8dbe51f3..ae4a686ff4f265be 100644
--- a/tools/perf/builtin-check.c
+++ b/tools/perf/builtin-check.c
@@ -33,7 +33,7 @@ struct feature_status supported_features[] = {
 	FEATURE_STATUS("dwarf", HAVE_DWARF_SUPPORT),
 	FEATURE_STATUS("dwarf_getlocations", HAVE_DWARF_GETLOCATIONS_SUPPORT),
 	FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),
-	FEATURE_STATUS("get_cpuid", HAVE_AUXTRACE_SUPPORT),
+	FEATURE_STATUS("auxtrace", HAVE_AUXTRACE_SUPPORT),
 	FEATURE_STATUS("libaudit", HAVE_LIBAUDIT_SUPPORT),
 	FEATURE_STATUS("libbfd", HAVE_LIBBFD_SUPPORT),
 	FEATURE_STATUS("libcapstone", HAVE_LIBCAPSTONE_SUPPORT),

That:

        FEATURE_STATUS("dwarf-unwind-support", HAVE_DWARF_UNWIND_SUPPORT),

Should also really be:

        FEATURE_STATUS("dwarf-unwind", HAVE_DWARF_UNWIND_SUPPORT),

For consistency, the get_cpuid/auxtrace also for consistency, I think.

- Arnaldo
