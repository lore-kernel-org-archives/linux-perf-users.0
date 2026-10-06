Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB818463B61
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Oct 2026 13:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293643; cv=none; b=snFr5II7w32G2y0cWcJ1ZCDQMw7unw7xpKoD5pK3N0jBBshU0GlIs6IYZR6wCFjksM5Uve/thXz2RU1NrW44M7TocbSv6SlSMRxM0jvRbvYYDKFTWkHKu2wTZFz3KeHlR2Bbv5tuD0CMdMbLSIxZJTml8UmbHlrjRTaJ5asZ0n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293643; c=relaxed/simple;
	bh=rfvg750VyCb/AEbsw/hurwO+oNANwew7D38aGIRgbDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH3p878YUgnen9UAXasZubTpOZFY/cU7b9NJsIesB0mdex6fytyBDTXFfu3R9nG+v9inB6ZH+KSq2FdQMyt5iTM3BhacvMMmFy8IRScOu9F7y6nl3mikmzIOP1JZGE6qzqlcAl6fzC0cTfkQOD8piQUtBczPHhwUp8CqSdZigN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm9Gb0WD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm9Gb0WD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56201F000FF;
	Tue,  6 Oct 2026 13:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791293641;
	bh=nGyxJzJBLXjRROwNps9ipuSBamy+aLQIkxNje113aNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hm9Gb0WDwLDv8w2tB2/M26G6zm+1Qu4xfw5GxZtpi+7QoyQ3QMe/5uJBu/ams+Jcu
	 aA55ic05UU+vm0Ba3HhQmD4die10I2rsVjSgHBOxjLSQkByohf/Ob0/6q87wgtKXL+
	 0AJH1uwCzz3e67O9WT0HEwf6sedY2bSp4IG9ffj9L/lFrE9ELJDPbe3R6qZrpeuvaF
	 dAlYrrde8BNFP67X2JPWlV5ZUcid/wYGtbL2M/J9cMsWmNVV7rd5FzBYak5uwAP7eh
	 AetgtVui8WQf4I5u8QjbtfSersafZWlFcratRgKnHFSkpuKPJUWN47VE+y1qQbFr81
	 hrLj9JRF27FnA==
Date: Tue, 6 Oct 2026 15:33:57 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com,
	namhyung@kernel.org, acme@redhat.com
Subject: Re: [PATCH 2/2] perf test attr: Fix wrong size expectation for events
Message-ID: <asT4xQW9Vy492Yyl@x2>
References: <20260924223027.799654-1-mpetlan@redhat.com>
 <20260924223027.799654-3-mpetlan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924223027.799654-3-mpetlan@redhat.com>

On Fri, Sep 25, 2026 at 12:30:27AM +0200, Michael Petlan wrote:
> Although config4 has been added into struct perf_event_attr, the size
> expectation for the struct hasn't been adjusted. This hasn't been
> noticed, since the testcase's return value has been ignored after
> rewriting the testcase to python until previous commit.
> 
> Fix that.
> 
> Fixes: 80cdf208117a36de82a30d210b3b8df0f193e75b ("tools headers UAPI: Sync linux/perf_event.h with the kernel sources")

> Fixes: cbbfba4847b8a5299d36e002bf864b21bb83295d ("perf: Add perf_event_attr::config4")

This cset changes a kernel header, kernel developers are not expected to
update tools/ living code, they are welcomed to do so, so it didn't
introduce a problem, so the cset that updates the tools/include/ is the
one that should be in the fixes.

I was going to do that when I noticed this:

 #define PERF_ATTR_SIZE_VER9                    144     /* add: config4 */
+#define PERF_ATTR_SIZE_VER10                   176     /* Add: sample_simd_{vec|pred}_reg_* */

in tools/include/uapi/linux/perf_event.h, i.e. with your patch it will
continue broken, as it is not taking into account this one:

commit eb89aef367e4701038869e1ddfa719463524e3e3
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
Date:   Mon Sep 14 09:40:43 2026 +0800

    perf headers: Sync perf_event.h/perf_regs.h with the kernel headers

    Sync the UAPI header changes of supporting SIMD/eGPRs/SSP sampling into
    corresponding tools UAPI headers.

So I'm updating your patch to have 176 instead of 144.

The test is still failing tho, for some other reason:

running '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-default'
test limitation '!aarch64'
excluded architecture list ['aarch64']
running '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-default-aarch64'
test limitation 'aarch64'
skipped [x86_64] '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-default-aarch64'
running '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-dwarf'
expected sample_type=45359, got 12583
FAILED '/home/acme/libexec/perf-core/tests/shell/attr/test-record-graph-dwarf' - match failure
---- end(-1) ----
 82: Perf attribute expectations test                                                                       : FAILED!

=== Test Summary ===
Passed main tests : 0
Passed subtests   : 0
Skipped tests     : 0
Failed tests      : 1
List of failed tests:
   82: Perf attribute expectations test
root@x2:~#

Investigating.

- Arnaldo
 
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/tests/shell/attr/base-record          | 2 +-
>  tools/perf/tests/shell/attr/base-stat            | 2 +-
>  tools/perf/tests/shell/attr/system-wide-dummy    | 2 +-
>  tools/perf/tests/shell/attr/test-record-dummy-C0 | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/attr/base-record b/tools/perf/tests/shell/attr/base-record
> index b44e4e6e4443..dd76fbdb628f 100644
> --- a/tools/perf/tests/shell/attr/base-record
> +++ b/tools/perf/tests/shell/attr/base-record
> @@ -5,7 +5,7 @@ group_fd=-1
>  flags=0|8
>  cpu=*
>  type=0|1
> -size=136
> +size=144
>  config=0|1
>  sample_period=*
>  sample_type=263
> diff --git a/tools/perf/tests/shell/attr/base-stat b/tools/perf/tests/shell/attr/base-stat
> index fccd8ec4d1b0..d769e69bb4f5 100644
> --- a/tools/perf/tests/shell/attr/base-stat
> +++ b/tools/perf/tests/shell/attr/base-stat
> @@ -5,7 +5,7 @@ group_fd=-1
>  flags=0|8
>  cpu=*
>  type=0
> -size=136
> +size=144
>  config=0
>  sample_period=0
>  sample_type=65536
> diff --git a/tools/perf/tests/shell/attr/system-wide-dummy b/tools/perf/tests/shell/attr/system-wide-dummy
> index a1e1d6a263bf..9806de3d9c9e 100644
> --- a/tools/perf/tests/shell/attr/system-wide-dummy
> +++ b/tools/perf/tests/shell/attr/system-wide-dummy
> @@ -7,7 +7,7 @@ cpu=*
>  pid=-1
>  flags=8
>  type=1
> -size=136
> +size=144
>  config=9
>  sample_period=1
>  # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> diff --git a/tools/perf/tests/shell/attr/test-record-dummy-C0 b/tools/perf/tests/shell/attr/test-record-dummy-C0
> index 91499405fff4..23e00e7f8ace 100644
> --- a/tools/perf/tests/shell/attr/test-record-dummy-C0
> +++ b/tools/perf/tests/shell/attr/test-record-dummy-C0
> @@ -10,7 +10,7 @@ cpu=0
>  pid=-1
>  flags=8
>  type=1
> -size=136
> +size=144
>  config=9
>  sample_period=4000
>  # PERF_SAMPLE_IP | PERF_SAMPLE_TID | PERF_SAMPLE_TIME |
> -- 
> 2.52.0
> 
