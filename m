Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5D3C2B8D
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896193; cv=none; b=m1DFh2eZFoG6fZJnU8Wgy3ZIL3bWnNMZzWbYo2uRqFeUGtoxEWs0c4+8r3dr74CnLB9eSdrQ7AOj9BGHkOz4lziVKTl6QpN0EkRoyfLYPyb+BZa3Q9SuHgUYA3qufhr0Svsf7UaMdkRr+Rx0J+W97S1I86lU5pWYIDIgofZQgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896193; c=relaxed/simple;
	bh=KNEEADgP2eVYjG3Nw16d6fJsProTQeneOrUcIDgAlp0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pnbkq5SQ3OMzK0vHicI0stnnd3NQUHbieweyLnK1SEU3LX/MqByllN9hzRWATvp+jF7VydSTilRvy0TD3n7EbAPIwkNSgQHI3p53DnUprLk40zOW/7thet4DXdRQac09harHHO5wszsfMnt+OD2wFDDrapReKH54mOC6RDha6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh4ByhHq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh4ByhHq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1964F1F000E9;
	Wed,  1 Jul 2026 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782896191;
	bh=QXBhKB9vaG5IqBDQOATDkQ1m3HsM/HPDVu7nCYRMyCQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kh4ByhHqLVUUnId3wTejScSzrTn7iMP3ZInvjl/k/sIl2xQWjFTPa3gjn8d6VJxsy
	 eNofUSq2ZfjjLNut0XhzyP5fo4H95i9AXa3pMg5k5KjXanNB/26EUwfxljEU/LCUAU
	 89Mp4Qbl1HdJu+vFb1gng09mjy3wQrX4LHs8wSfFFaoaexqtX5jqN/DKM/EJ2hq3u0
	 weh1MGghXiJ60KSpLxnAFCh1uIMus/8M/p8ttSWhk1R+y0y1TEtAM2KUb3Vv1juend
	 jfNQ4I8rQw2Sxzd/9WC1ajA6H3JZPSzAJxjT4c7nJquwoBkcvBaqdH8fAgxJnBmXwo
	 Eoq8Ga2oL9cOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] tool/perf: Move auxtrace_record__init for
 powerpc-vpadtl as separate utility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260701084115.80383-2-atrajeev@linux.ibm.com>
References: <20260701084115.80383-1-atrajeev@linux.ibm.com>
 <20260701084115.80383-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:56:30 +0000
Message-Id: <20260701085631.1964F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Memory allocation failure in vpa_dtl_recording_init silently retur=
ns success, masking -ENOMEM and causing a subsequent NULL pointer dereferen=
ce.
- [Low] Missing explicit inclusion of POSIX standard headers <stdlib.h> and=
 <limits.h> breaks musl libc compatibility.
--

(Note: The format of this report is altered to provide a free-form summary =
of the findings, rather than inline diff comments, due to system recitation=
 restrictions.)

commit 9f7d3d8f8dc04ee94edc0507b7b561997e9bd6a5
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tool/perf: Move auxtrace_record__init for powerpc-vpadtl as separate utility
   =20
This commit extracts the auxtrace_record__init logic for powerpc-vpadtl int=
o a
separate utility file, vpa-dtl.c, allowing other PMUs to share the auxtrace
infrastructure.

[Severity: High]
When zalloc() fails in the new vpa_dtl_recording_init() function, it returns
NULL. However, because the refactored function no longer takes the err poin=
ter
argument, it cannot propagate the -ENOMEM error back up the stack.=20

In auxtrace_record__init(), the err variable is initially set to 0. If
vpa_dtl_recording_init() returns NULL due to memory exhaustion,
auxtrace_record__init() will also return NULL while leaving the error code
as 0 (success).=20

Could this regression lead to memory corruption or crashes? Since
pos->needs_auxtrace_mmap is already set to true earlier in the function,
the caller will see a success code and incorrectly proceed to map the auxtr=
ace
buffer. Eventually, this reaches __auxtrace_mmap__read(), which evaluates
itr->alignment. If itr is NULL because of the masked allocation failure, wo=
n't
this trigger a NULL pointer dereference?

[Severity: Low]
The newly added file tools/perf/arch/powerpc/util/vpa-dtl.c uses the POSIX
function free() in powerpc_vpadtl_free() and the constant UINT_MAX in
powerpc_vpadtl_recording_options().

Are we missing some required include directives here? The file doesn't seem=
 to
explicitly include stdlib.h or limits.h. While this might compile fine under
glibc due to implicit header inclusions, does this regression break compila=
tion
on stricter libc implementations like musl?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701084115.8038=
3-1-atrajeev@linux.ibm.com?part=3D1
