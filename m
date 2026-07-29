Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4A485CFA
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329755; cv=none; b=AXeTSYarYAk/RlgUV7C4iTBEhN7kAc/B9V/73XBa08lvEE5C6yHcD/BebYxC17RVAcs/O6TfP7noDhB6tkkKnrZLeIL9LcIq2nXpjIm0QL1IvQFXG4CBOjuPyBjV++ZG+2k/kv7JiPDj7RwXrCIrlO/xtKi429MXHsMY1HGw+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329755; c=relaxed/simple;
	bh=2ASKqqeHrte8mls9UzU+/4r8hR8AwgeosCcpGkbSAk0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oF59QeHrZXKhZOcEAfh5MTWja+AI3+j8hUZZ1i3YFE4ncdUQH6LZ2ekwhE3eJc3lrIp/bLLiYJoJm0jDrosELm4guSG50vaGKqtf3Se59CFVSa5/0SAGoJ6XN4qKPnYB9SXnwll8dtsThT8jfmhECgC5xZnmkTLPxViHJC5pdzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDdNsYKk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDdNsYKk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629FC1F00ADB;
	Wed, 29 Jul 2026 12:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329740;
	bh=XEAyon7/hamX8/8Y1KdXrsbzLppuRkRONusqQVpIPoU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDdNsYKklBFw5mlzR0U+zAU3nchyQEd6FfChqjS9uLXJELJ6h4jyH7gfy9vXslV8U
	 y2i+vuKdUEBkKDLMe3Sz+p6/4WLlBvexTRUHyWmFbK3xFSMtsCd8bYGLC6rgL5Y4ie
	 7xYQKwo6sDMcjrVGmTrKoaVgBPJOVMpShDd+r4y4usK2fUOiE6de1ScGQAu2qFRdTR
	 J+U3AoP85M/Hk81cpP8EQ60xjqLJome3nk2W5kj41O/BYqHdB8Gr0djem6ERxONKx0
	 pdeFBfMymmiKvJQDKcgK+7n9OJw2GTFFadbqkObNHxcI2YQvR+6RXgLaia1EKvuVPH
	 lQy1IMappHa6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 1/6] tools/perf: Move powerpc VPA-DTL auxtrace init
 into a separate file
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729124400.65009-2-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
 <20260729124400.65009-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:55:39 +0000
Message-Id: <20260729125540.629FC1F00ADB@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing forward declarations for `struct evsel` and `struct auxtrac=
e_record` in `powerpc-vpadtl.h`.
--

--- Patch [1]: [PATCH V4 1/6] tools/perf: Move powerpc VPA-DTL auxtrace ini=
t into a separate file ---
commit d6642397942d2744eabc1f173cb06052b8c22930
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Move powerpc VPA-DTL auxtrace init into a separate file

This commit factors out the VPA-DTL auxtrace recording initialization logic
from auxtrace.c into a new file, vpa-dtl.c. It reduces auxtrace.c to a thin
dispatcher that calls per-PMU init functions like vpa_dtl_recording_init().
This preparation aims to accommodate additional PMUs like HTM without
creating a monolithic file.

[ ... ]

> diff --git a/tools/perf/util/powerpc-vpadtl.h b/tools/perf/util/powerpc-v=
padtl.h
> index ca809660b9bb7..41e09b17a353d 100644
> --- a/tools/perf/util/powerpc-vpadtl.h
> +++ b/tools/perf/util/powerpc-vpadtl.h
> @@ -20,4 +20,5 @@ struct perf_pmu;
>  int powerpc_vpadtl_process_auxtrace_info(union perf_event *event,
>  				  struct perf_session *session);
> =20
> +struct auxtrace_record *vpa_dtl_recording_init(struct evsel *pos, int *e=
rr);

[Severity: Low]
This isn't a bug, but could we add forward declarations for struct evsel and
struct auxtrace_record before they are used in this function prototype?

Without prior declarations, using undeclared structures in a function
parameter list gives them function prototype scope in C. While the current
inclusion order in the source files hides the issue, this could cause
compiler warnings about structures declared inside a parameter list, or
build failures if this header is included in a different context. Adding
forward declarations here would also align with the perf subsystem guidelin=
es
for header files.

>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729124400.6500=
9-1-atrajeev@linux.ibm.com?part=3D1
