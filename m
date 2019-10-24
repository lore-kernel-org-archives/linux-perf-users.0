From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: linux-next: bad merge resolution in the tip tree (Was: Linux-next:
 20191022: perf: bpf_helpers_doc.py: not found)
Date: Fri, 25 Oct 2019 09:14:12 +1100
Message-ID: <20191025091412.77bea416@canb.auug.org.au>
References: <CA+G9fYvWdkmmkrq7hvADZ-1qnUNEwRULoTPfOQDnu1aZW8cDEA@mail.gmail.com>
        <20191023024149.GA29009@leoy-ThinkPad-X240s>
        <CAEUSe79P0z4N=3TnF9ytWfemX8NqY1Mr_zt6PDgMAZQb=4ChpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rQjFlvQ/A_Sb7.IYHqDhM55";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEUSe79P0z4N=3TnF9ytWfemX8NqY1Mr_zt6PDgMAZQb=4ChpA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>, Leo Yan <leo.yan@linaro.org>, Naresh Kamboju <naresh.kamboju@linaro.org>, Linux-Next Mailing List <linux-next@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, open list <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, lkft-triage@lists.linaro.org
List-Id: linux-perf-users.vger.kernel.org

--Sig_/rQjFlvQ/A_Sb7.IYHqDhM55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ingo,

On Thu, 24 Oct 2019 13:05:54 -0500 Daniel D=C3=ADaz <daniel.diaz@linaro.org=
> wrote:
>
> By the way, while looking at this, we found this unresolved conflict
> in the tree:
> -----8<----------8<----------8<-----
>   $ git show 2b5d5b1927a8c
>   commit 2b5d5b1927a8c17bf3ce5b4f781c6ba11e02cadd
>   Merge: c1e45431c592 ae79d5588a04
>   Author: Ingo Molnar <mingo@kernel.org>
>   Date:   Mon Oct 21 07:13:15 2019 +0200
>=20
>       Merge branch 'perf/core'
>=20
>       Conflicts:
>               tools/perf/check-headers.sh
>=20
>   diff --cc tools/perf/check-headers.sh
>   index 499235a41162,93c46d38024e..1f73e6f7438c
>   --- a/tools/perf/check-headers.sh
>   +++ b/tools/perf/check-headers.sh
>   @@@ -28,7 -28,7 +28,11 @@@ arch/x86/include/asm/disabled-features.
>     arch/x86/include/asm/required-features.h
>     arch/x86/include/asm/cpufeatures.h
>     arch/x86/include/asm/inat_types.h
>   ++<<<<<<< HEAD
>    +arch/x86/include/asm/emulate_prefix.h
>   ++=3D=3D=3D=3D=3D=3D=3D
>   + arch/x86/include/asm/msr-index.h
>   ++>>>>>>> perf/core =20
>     arch/x86/include/uapi/asm/prctl.h
>     arch/x86/lib/x86-opcode-map.txt
>     arch/x86/tools/gen-insn-attr-x86.awk
> ----->8---------->8---------->8----- =20
>=20
> That's still on next-20191024.
>=20
> Greetings!
>=20
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org

--=20
Cheers,
Stephen Rothwell

--Sig_/rQjFlvQ/A_Sb7.IYHqDhM55
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2yIjQACgkQAVBC80lX
0GxC5gf/anJx6HndU8+qLPUfGyZwQH0nsqze2ppYHbaiovBAxrUPZ3F6AFLCihdc
cakYc0X887BZNddUDPvFdF+zCQhWBnXXub1UzDZhecq7RbJWTjFD9yW/Rs1yRzYJ
O/vYDRNDtYK/qJELnpExsHmInlA630gwWifiOFInhiMJksRRpeNlCOnk1dWD5U5G
z84dLfIHJxw+ZEAGUr0DsTeFinzb8CxXzx95kz/Ggb+TWoPioq1doExBzBSDji++
QUoKKZ9+3UbTzQwCk7CdIbPmhGXfKKZoMmvLeIpcfXnybWADDZam1VyRMgss7O5O
R8CpVoRYm93iHoD/jHEcouzq5R8n1Q==
=YiY5
-----END PGP SIGNATURE-----

--Sig_/rQjFlvQ/A_Sb7.IYHqDhM55--
