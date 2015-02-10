From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] perf symbols: Define STT_GNU_IFUNC for glibc 2.9 and
 older.
Date: Tue, 10 Feb 2015 23:24:44 +0900
Message-ID: <20150210142444.GC27487@danjae>
References: <1423528286-13630-1-git-send-email-vlee@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1423528286-13630-1-git-send-email-vlee@twopensource.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vinson Lee <vlee@twopensource.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Waiman Long <Waiman.Long@hp.com>, Stephane Eranian <eranian@google.com>, Anton Blanchard <anton@samba.org>, Avi Kivity <avi@cloudius-systems.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Vinson Lee <vlee@twitter.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Vinson,

On Mon, Feb 09, 2015 at 04:29:37PM -0800, Vinson Lee wrote:
> From: Vinson Lee <vlee@twitter.com>
>=20
> The token STT_GNU_IFUNC is not available with glibc 2.9 and older.
> Define this token if it is not already defined.
>=20
> This patch fixes this build errors with older versions of glibc.
>=20
>   CC       util/symbol-elf.o
> util/symbol-elf.c: In function =E2=80=98elf_sym__is_function=E2=80=99=
:
> util/symbol-elf.c:75: error: =E2=80=98STT_GNU_IFUNC=E2=80=99 undeclar=
ed (first use in this function)
> util/symbol-elf.c:75: error: (Each undeclared identifier is reported =
only once
> util/symbol-elf.c:75: error: for each function it appears in.)
> make: *** [util/symbol-elf.o] Error 1
>=20
> Cc: stable@vger.kernel.org # 3.17+
> Signed-off-by: Vinson Lee <vlee@twitter.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/symbol-elf.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-el=
f.c
> index 06fcd1b..eafee11 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -69,6 +69,10 @@ static inline uint8_t elf_sym__type(const GElf_Sym=
 *sym)
>  	return GELF_ST_TYPE(sym->st_info);
>  }
> =20
> +#ifndef STT_GNU_IFUNC
> +#define STT_GNU_IFUNC 10
> +#endif
> +
>  static inline int elf_sym__is_function(const GElf_Sym *sym)
>  {
>  	return (elf_sym__type(sym) =3D=3D STT_FUNC ||
> --=20
> 1.8.2.1
>=20
