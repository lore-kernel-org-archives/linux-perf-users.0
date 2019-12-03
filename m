From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf is unable to read dward from go programs
Date: Tue, 3 Dec 2019 11:22:34 +0100
Message-ID: <20191203102234.GE17468@krava>
References: <CABWYdi2jvPUq128XDv_VbY=vFknFyJHbUR=0_K9WuA0mFTkPvg@mail.gmail.com>
 <CABWYdi3k9QvFOEd_hFG16LVE=BiokO4hWp50nZcxYwbWfxeE3g@mail.gmail.com>
 <20191129134929.GA26903@krava>
 <20191129151436.GB26963@kernel.org>
 <CABWYdi19LmOHC0Ect-8vNXz0uF2tNC1XmDQfMn0fmYOt2yJH9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABWYdi19LmOHC0Ect-8vNXz0uF2tNC1XmDQfMn0fmYOt2yJH9w@mail.gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Babrou <ivan@cloudflare.com>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, kernel-team <kernel-team@cloudflare.com>
List-Id: linux-perf-users.vger.kernel.org

On Mon, Dec 02, 2019 at 11:49:55AM -0800, Ivan Babrou wrote:
> I've tried building with libdw with mixed results:
>=20
> 1. I can see stacks from some Go programs that were invisible before (yay=
!)
>=20
> 2. Warnings like below still appear in great numbers for a system-wide
> flamegraph:
>=20
> BFD: Dwarf Error: found dwarf version '18345', this reader only
> handles version 2, 3 and 4 information.
>=20
> I'm not sure how to pinpoint this to a particular binary and would
> appreciate some help with this.

I'd need some way of reproducing this, could you please
paste me command lines you used?

>=20
> 3. It takes minutes to produce a flamegraph of a running system
> whereas before it only took seconds. See this flamegraph of "perf
> script" itself:
>=20
> * https://gist.github.com/bobrik/a9c46cffe9daa5840abd137443d8bab0#file-fl=
amegraph-perf-svg
>=20
> Seems like there is no caching and debug info is getting reparsed
> continuously for every stack. It's possible that it was not an issue
> before, because we spent no time decompressing dwarf.

possibly, if we have some clear reproducer we can hand it
to the libdw guy that helped us develop this

>=20
> 4. Pretty much all luajit frames stacks that were marked as unknown
> before are now gone.
>=20
> See before and after here: https://imgur.com/a/1LNfqAk
>=20
> Before:
>=20
> nginx-cache 94572 446642.722028:   10101010 cpu-clock:
>             5607d8d56718 ngx_http_lua_shdict_lookup+0x48 (inlined)
>             5607d8d5a09d ngx_http_lua_ffi_shdict_incr+0xcd
> (/usr/local/nginx-cache/sbin/nginx-cache)
>             560802fe58e4 [unknown] (/tmp/perf-94572.map)
>=20
> After:
>=20
> nginx-cache 94572 446543.008703:   10101010 cpu-clock:
>             5607d8d56718 ngx_http_lua_shdict_lookup+0x48 (inlined)
>             5607d8d59da7 ngx_http_lua_ffi_shdict_get+0x197
> (/usr/local/nginx-cache/sbin/nginx-cache)
>=20
> The key is /tmp/perf-*.map frame at the bottom. I don't know if it's
> expected, but we grew dependent on knowing this.
>=20
> 5. Special [[stack]], [[heap]] and [anon] frames are also gone, and
> you can see the following during "perf script" run:
>=20
> open("[stack]", O_RDONLY)               =3D -1 ENOENT (No such file or di=
rectory)
> open("[heap]", O_RDONLY)                =3D -1 ENOENT (No such file or di=
rectory)
> open("//anon", O_RDONLY)                =3D -1 ENOENT (No such file or di=
rectory)

strange, let's start with the reproducer and I'll check
on this if I see it

thanks,
jirka
