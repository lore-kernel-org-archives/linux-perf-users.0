From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] Correctly handle symbols in VDSO
Date: Wed, 9 Apr 2014 17:35:47 +0200
Message-ID: <20140409153546.GA19506@krava.brq.redhat.com>
References: <D6A5CDD8-F8F1-4C9D-8BCF-83A739FD6A2F@tbricks.com>
 <87eh19y8cm.fsf@sejong.aot.lge.com>
 <3C60FB26-A78B-4E37-B4A6-E6F7283CEB4C@tbricks.com>
 <20140408154101.GA21094@krava.brq.redhat.com>
 <A7CC2084-4F71-436C-9AEC-394F66A4981E@tbricks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <A7CC2084-4F71-436C-9AEC-394F66A4981E@tbricks.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vladimir Nikulichev <nvs@tbricks.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On Wed, Apr 09, 2014 at 10:46:13AM +0400, Vladimir Nikulichev wrote:
> Hi,
>=20
> On Apr 8, 2014, at 7:41 PM, Jiri Olsa <jolsa@redhat.com> wrote:
>=20
> > hi,
> > could you please put explanation from first email
> > into the patch changelog?
> >=20
> > cc-ing lkml
> >=20
> > thanks,
> > jirka
>=20
>=20
> OK, pasting it together:

ook

hum, your email's encoding kills my 'git am' :-\
also 'perf tools: Adjust symbols in VDSO' should go into the
email subject

I processed this patch by hand this time

thanks,
jirka

>=20
> ---------------------------------------------------------------------=
------------------------------------------------------
>=20
> perf tools: Adjust symbols in VDSO
>=20
> pert-report doesn't resolve function names in VDSO:
>=20
> $ perf report --stdio -g flat,0.0,15,callee --sort pid
> ...
>             8.76%
>                0x7fff6b1fe861
>                __gettimeofday
>                ACE_OS::gettimeofday()
> ...
>=20
> In this case symbol values should be adjusted the same way as for exe=
cutables, relocatable objects and prelinked libraries.
>=20
> After fix:
>=20
> $ perf report --stdio -g flat,0.0,15,callee --sort pid
> ...
>             8.76%
>                __vdso_gettimeofday
>                __gettimeofday
>                ACE_OS::gettimeofday()
> =E2=80=A6
>=20
> Signed-off-by: Vladimir Nikulichev <nvs@tbricks.com>
>=20
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-el=
f.c
> index 3b7dbf5..6864661 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -6,6 +6,7 @@
> #include <inttypes.h>
>=20
> #include "symbol.h"
> +#include "vdso.h"
> #include <symbol/kallsyms.h>
> #include "debug.h"
>=20
> @@ -618,6 +619,7 @@ int symsrc__init(struct symsrc *ss, struct dso *d=
so, const char *name,
> 		GElf_Shdr shdr;
> 		ss->adjust_symbols =3D (ehdr.e_type =3D=3D ET_EXEC ||
> 				ehdr.e_type =3D=3D ET_REL ||
> +				is_vdso_map(dso->short_name) ||
> 				elf_section_by_name(elf, &ehdr, &shdr,
> 						     ".gnu.prelink_undo",
> 						     NULL) !=3D NULL);
