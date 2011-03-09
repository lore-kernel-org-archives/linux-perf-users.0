From: Lin Ming <minggr@gmail.com>
Subject: Re: [PATCH] perf: Avoid resolving [kernel.kallsyms] to real path for
 buildid cache
Date: Wed, 9 Mar 2011 22:38:52 +0800
Message-ID: <AANLkTikMi0TR9pUSG3bWdRvEOwKdFQ-5Ex5trjGEQBx0@mail.gmail.com>
References: <1299165837-27817-1-git-send-email-ming.m.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47856 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab1CIOix convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 9 Mar 2011 09:38:53 -0500
In-Reply-To: <1299165837-27817-1-git-send-email-ming.m.lin@intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>, Lin Ming <ming.m.lin@intel.com>
Cc: Han Pingtian <phan@redhat.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org

Hi, Arnaldo

Could you have a look at this patch?

Thanks,
Lin Ming

On Thu, Mar 3, 2011 at 11:23 PM, Lin Ming <ming.m.lin@intel.com> wrote:
> kallsyms has a virtual file name [kernel.kallsyms].
> Currently, it can't be added to buildid cache successfully
> because the code(build_id_cache__add_s) tries to resolve
> [kernel.kallsyms]to a real absolute pathname and that fails.
>
> Fixes it by not resolving it and just use the name [kernel.kallsyms].
> So dir ~/.debug/[kernel.kallsyms] is created.
>
> Original bug report at:
> https://lkml.org/lkml/2011/3/1/524
>
> Tested-by: Han Pingtian <phan@redhat.com>
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> ---
> =A0tools/perf/util/header.c | =A0 11 ++++++++---
> =A01 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 72c124d..1f8883b 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -271,11 +271,15 @@ int build_id_cache__add_s(const char *sbuild_id=
, const char *debugdir,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *name, =
bool is_kallsyms)
> =A0{
> =A0 =A0 =A0 =A0const size_t size =3D PATH_MAX;
> - =A0 =A0 =A0 char *realname =3D realpath(name, NULL),
> - =A0 =A0 =A0 =A0 =A0 =A0*filename =3D malloc(size),
> + =A0 =A0 =A0 char *realname, *filename =3D malloc(size),
> =A0 =A0 =A0 =A0 =A0 =A0 *linkname =3D malloc(size), *targetname;
> =A0 =A0 =A0 =A0int len, err =3D -1;
>
> + =A0 =A0 =A0 if (is_kallsyms)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 realname =3D (char *)name;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 realname =3D realpath(name, NULL);
> +
> =A0 =A0 =A0 =A0if (realname =3D=3D NULL || filename =3D=3D NULL || li=
nkname =3D=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_free;
>
> @@ -307,7 +311,8 @@ int build_id_cache__add_s(const char *sbuild_id, =
const char *debugdir,
> =A0 =A0 =A0 =A0if (symlink(targetname, linkname) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;
> =A0out_free:
> - =A0 =A0 =A0 free(realname);
> + =A0 =A0 =A0 if (!is_kallsyms)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free(realname);
> =A0 =A0 =A0 =A0free(filename);
> =A0 =A0 =A0 =A0free(linkname);
> =A0 =A0 =A0 =A0return err;
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-=
users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
