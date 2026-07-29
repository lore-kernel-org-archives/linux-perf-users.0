Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FB48380A
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329731; cv=none; b=BFxuKp9Hq0G3PqKREtgfc82uCpuH3bTDYh/HMD4ecPqoOQRVWEoKtBVtzH0CEwclMjyy7IoAk8Lvp6Wv63iNJMeS7tKkXqyYNo48qSiTN3TGvN2CvG/dzd5jjvfSD47W/qUOvHPfKbOATD91l/sevbaXa45s7jU0dtut2T85zBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329731; c=relaxed/simple;
	bh=ua40JNR8uTG2IR/qwVIyi2kBbRISulrxhmKzebNdHFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rFZcFQRflQr/EOmHOPl8QmMPz3RKEsqu+g9NOxgZbcM/yRN1AZ32au2OPW4IJ/WoIiP24oOAYR70JiF50srzJnQmqYiBCIpL7I/VGLxaUp39THJqxczM1Kwc7Xs5T/ccLVrRixgCUoU+FLsHPTZZfMjBiUe4KHoX8uvejZzKm84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZE6++mZ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZE6++mZ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4FB1F00A3A;
	Wed, 29 Jul 2026 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785329723;
	bh=E79GNoNOvGrPnChfqYmfgqYDRpTWUWIQ8PyzLhPQDno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZE6++mZ8l3Dv2dq81rwpJd2JJsgcdxodTrWdYIt0rcgwWflV0c4K2nZfX6uwNqtpK
	 d5V1o/Vgh26khMpeynE2w7mZsZDtrD5EbaTiHJG2BtZWlY4Yx83ilHQSm/oE3oYwUv
	 X8jwVhklZsVw7xA6HbOKu6hyVG4OV2HhvV898nG69xTVhZDk0VvQWXrt+taEV+o+LL
	 IXsbb1ws7d8VxYVaT1lgZZtD2wZ37IV+ylgbBRDZavI0IsB9CURfiVhOKcFJ7KR1nH
	 Wihgrdb6VqARfoyamjg4dsJRlHN1aJOvhBTIgvm9J2TGXYmX4jUeFMO2anzq3hjcU+
	 Pd2hsvjK/Fvkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 6/6] tools/perf: Add perf tool support for processing
 powerpc HTM AUXTRACE records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260729124400.65009-7-atrajeev@linux.ibm.com>
References: <20260729124400.65009-1-atrajeev@linux.ibm.com>
 <20260729124400.65009-7-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 12:55:23 +0000
Message-Id: <20260729125523.9D4FB1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing explicit POSIX standard header inclusions for libc function=
s and constants (musl compatibility).
--

--- Patch [6]: [PATCH V4 6/6] tools/perf: Add perf tool support for process=
ing powerpc HTM AUXTRACE records ---
commit a4f98fe075ced1d3def8964f0504e272f95ab7a4
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add perf tool support for processing powerpc HTM AUXTRACE recor=
ds

This commit introduces support for processing powerpc HTM AUXTRACE records
in the perf tool. It reads CPU configurations to map AUX buffers correctly
and handles writing trace data and memory configuration records to files.

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> index 0ef7ecd18c6f3..268cba1e81c91 100644
> --- a/tools/perf/util/powerpc-htm.c
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -14,9 +14,14 @@
>  #include "auxtrace.h"
>  #include "color.h"
>  #include "powerpc-htm.h"
> +#include <errno.h>
>  #include "debug.h"
>  #include "sample.h"

[Severity: Low]
Does this file need additional explicit POSIX header inclusions for musl
compatibility?

Functions like open(), write(), close(), calloc(), and snprintf(), as well
as constants like O_CREAT and O_WRONLY, are used later in this file. Without
explicitly including <fcntl.h>, <unistd.h>, <stdio.h>, <stdlib.h>, and
<string.h> at the top, the perf tool might fail to compile against musl lib=
c,
which does not implicitly include headers.

> =20
> +#include <linux/unaligned.h>
> +
> +struct perf_session;
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729124400.6500=
9-1-atrajeev@linux.ibm.com?part=3D6
