Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416AD30BF70
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 07:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964106; cv=none; b=GSqlmMtLK2N23nIOqNQ8a+ezJPD/Me+w8yryCWlcprsAE5i1F+T3VflHSpZs8zIv27GWs4PaCWxtQZGoaBU+/gmwef+ctDgxDkumRbsMDgfbanSlDjfL2TBCVG7GxFMN0YBjW8bwthLrA/V3gNdEZR+e/F1z9m8C2yR/fmpOoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964106; c=relaxed/simple;
	bh=cMZNAi0pEm+CkdUPDiF82q2uEPL1zLjE0DlHdCyBkm4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oAmcKlNwQdhVTRpGCAk5lrYYjUqfmGynwevyFsJPy3e9Cgr+YyPwnJRszTC/xDCM1kCcxX8mccUUHpcFleZ7wYVp4skHetth8Goq3yBsS9PpLzDRiOnCnvbuFFbInuRys2nId5HXNCmETre0O5OAdEYzeAkcijvNN19J+MtTrik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYzOK5V4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYzOK5V4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67CE1F000E9;
	Sat, 25 Jul 2026 07:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784964105;
	bh=zLZzmYI6qg/eiLROrnLRMiVBx9UwV6K8yBEakmJnLJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mYzOK5V4L0Z3Gx5ePRXoyoXis28Foejx+Vn+/MKW5dvfS8IQYilXwIl+9yZhtxrv+
	 EzuqWqdI70+R+1ruwzJhx4ek4Xs1lxEOe/KAgx64lKiQtlZGvnp9KhWVIW2YYBC06e
	 h5tCMgbeWCUzmgXYbWPa7u25GWN8Oj7w9LjHEQhrGQeR5GLxQyC+VUUUHJxuPPrLJR
	 4nsiH0DcPifzEMKwZv/0Rwucx1pNPxU+abE+Lw92yAtwvW5W4Pp2v+RD92CbUm6xJc
	 Ey+/0qYgCQWAXVqI4jHzkL0OlwHBsJkTvsII96EjEn8NLPxlypie/YJWpfFAvpBPSl
	 hklYJMm5dSZGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 5/6] tools/perf: Add powerpc HTM auxtrace event
 processing support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725070747.81435-6-atrajeev@linux.ibm.com>
References: <20260725070747.81435-1-atrajeev@linux.ibm.com>
 <20260725070747.81435-6-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:21:44 +0000
Message-Id: <20260725072144.E67CE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The file `powerpc-htm.c` calls `zalloc()` but fails to include `<l=
inux/zalloc.h>`, resulting in an implicit function declaration.
- [Low] The file `powerpc-htm.c` embeds `struct auxtrace_queues` and calls =
its API but fails to directly include `"auxtrace.h"`, relying on brittle im=
plicit inclusion.
--

--- Patch [5]: [PATCH V3 5/6] tools/perf: Add powerpc HTM auxtrace event pr=
ocessing support ---
commit 306ea78646ef6e5fe95dbad9977aff1241d1027a
Author: Athira Rajeev <atrajeev@linux.ibm.com>

tools/perf: Add powerpc HTM auxtrace event processing support

This commit adds the powerpc-htm.c decode stub for powerpc HTM auxtrace.
It wires the dispatch in perf_event__process_auxtrace_info() to call
powerpc_htm_process_auxtrace_info().

> diff --git a/tools/perf/util/powerpc-htm.c b/tools/perf/util/powerpc-htm.c
> new file mode 100644
> --- /dev/null
> +++ b/tools/perf/util/powerpc-htm.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <inttypes.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <errno.h>
> +#include <endian.h>
> +#include "util/evsel.h"
> +#include "util/evlist.h"
> +#include "util/session.h"
> +#include "color.h"
> +#include "powerpc-htm.h"
> +#include "debug.h"
> +#include "sample.h"
> +
> +struct powerpc_htm {
> +	struct auxtrace		auxtrace;
> +	struct auxtrace_queues	queues;

[Severity: Low]
Should this file explicitly include "auxtrace.h"?

The code embeds struct auxtrace_queues here, and later calls
auxtrace_queues__init(), both of which are defined in "auxtrace.h". Relying
on implicit inclusion (for example, through "util/evlist.h") currently works
but could break the build if intermediate headers are refactored in the
future.

[ ... ]

> +int powerpc_htm_process_auxtrace_info(union perf_event *event,
> +				      struct perf_session *session)
> +{
> +	struct perf_record_auxtrace_info *auxtrace_info =3D &event->auxtrace_in=
fo;
> +	struct powerpc_htm *htm;
> +	int err;
> +
> +	if (auxtrace_info->header.size < sizeof(struct perf_record_auxtrace_inf=
o) +
> +					 HTM_AUXTRACE_PRIV_FIXED)
> +		return -EINVAL;
> +
> +	htm =3D zalloc(sizeof(struct powerpc_htm));

[Severity: High]
Does this implicit function declaration cause a build failure or pointer
truncation?

The function zalloc() is used here, but <linux/zalloc.h> is not included in
this file. Because the kernel build system uses -Werror, this missing header
could trigger a build failure.

If -Werror were disabled, the compiler would assume zalloc() returns a 32-b=
it
integer. On 64-bit architectures like PowerPC, this truncates the 64-bit
pointer. When extended back to 64 bits during assignment, the higher bits a=
re
lost, which could result in a segmentation fault upon dereference.

Should <linux/zalloc.h> be included to ensure the return type is properly
defined?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725070747.8143=
5-1-atrajeev@linux.ibm.com?part=3D5
