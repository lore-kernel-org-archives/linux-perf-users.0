Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.68.32.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975461;
	b=0Wg8Rr5LN2Mm5E8Sj8jZ1sEG6hAQrrJq0W2Hn81LjK6QXoQya3BOV9tTDSaIZUGI7iVI
	 CxsUpgm/HilYfdhoY2hFUvtt/pird0bYN11ZUsSliMGbS/Grx7cITjGI5PL8w0He8rUq0
	 MPYj7mfQN3CEugsMi15JeMNJm2sPcXs84EaJdRBESHzOYhaMaisyIZI2/MmjZy/QNaLdf
	 z1cl4SS2qOlOFJ14GasVVSQb4+E1EqIhLlkzvAx6GaL/cfFzYTiEfu67VqqflD5VcCLJa
	 lEN0KxL0TFgFkKyPxQ4dqJRY4SuBx09q1Plt8oahQtist2/t2jv5Sbs6sxIsshxFfoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975461;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Operating-System:X-gpg-fingerprint:X-gpg-key:X-Echelon-Enable:
	 X-TKUeV:X-message-flag;
	bh=5V/5TAB96ndPwiAAKCMcB/cnjrnPTc++uezTCortw4s=;
	b=ubXnskYDrPrBisjTrmljcjaAGRsxef+wT6qrBpeJj2T/+NzK2fkIDuHqALCh2/YBcHyx
	 TOPIZ35jtLAplcY416MdFesiQVto0fnGFNDwEqH+xffmBe16Qf8RIe7lg4P8eBFH7tSCW
	 GTycQLWHH37vTsY8+T2y11GYW2aSxRBTjIcUhNiTEYxXFHg9CiSF1Io87mVzA18I3ljvB
	 8ofMiax0U9NztO0A/wE15TfPfjNErihNyD/hQwVMKPOuGFo02ukSiY6BgVdE4WyEAk7u8
	 ZSrypAHIpoKIBDFIfj5ybgCtqWazBCxa0xfF4DqJJA6jWwayjT/G0cv0ZS6YKxZrw6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lug-owl.de;
	spf=pass smtp.mailfrom=lug-owl.de;
	arc=none smtp.remote-ip=188.68.32.151
Received: from lug-owl.de (lug-owl.de [188.68.32.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ECB606A31A;
	Mon, 26 Oct 2026 00:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0ECB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lug-owl.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lug-owl.de
Received: by lug-owl.de (Postfix, from userid 1001)
	id E4950422D6; Mon, 26 Oct 2026 01:44:11 +0100 (CET)
Date: Mon, 26 Oct 2026 01:44:11 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v3 4/5] alpha: add HAVE_PERF_REGS and
 HAVE_PERF_USER_STACK_DUMP support
Message-ID: <at6iW11clMShlGCq@lug-owl.de>
References: <20261018-alpha-perf-regs-v3-v3-0-52be85332c57@gmail.com>
 <20261018-alpha-perf-regs-v3-v3-4-52be85332c57@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mslrvrPhqrcBcnNc"
Content-Disposition: inline
In-Reply-To: <20261018-alpha-perf-regs-v3-v3-4-52be85332c57@gmail.com>
X-Operating-System: Linux chamaeleon 6.12.113+deb13-amd64 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear
 warfare test the bombastical terror of flooding the spy listeners explosion
 sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare
 test the bombastical terror of flooding the spy listeners explosion sex
 drugs and rock'n'roll
X-message-flag: Please send plain text messages only. Do not send HTML
 emails. Thank you. 


--mslrvrPhqrcBcnNc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 2026-10-18 10:22:04 -0400, Matt Turner <mattst88@gmail.com> wrote:
> Let perf sample registers and dump the user stack, which is what the
> perf tool needs for --call-graph dwarf.

After this patch series, it conflicts with previous upstream changes:

[=E2=80=A6]
> diff --git a/arch/alpha/kernel/perf_regs.c b/arch/alpha/kernel/perf_regs.c
> new file mode 100644
> index 000000000000..33ea2e831ba0
> --- /dev/null
> +++ b/arch/alpha/kernel/perf_regs.c
> @@ -0,0 +1,64 @@
[=E2=80=A6]
> +int perf_reg_validate(u64 mask)
> +{
> +	if (!mask || mask & REG_RESERVED)
> +		return -EINVAL;
> +
> +	return 0;
> +}
[=E2=80=A6]

# CC      arch/alpha/kernel/perf_regs.o
  alpha-linux-gcc -Wp,-MMD,arch/alpha/kernel/.perf_regs.o.d -nostdinc -I./a=
rch/alpha/include -I./arch/alpha/include/generated -I./include -I./include =
-I./arch/alpha/include/uapi -I./arch/alpha/include/generated/uapi -I./inclu=
de/uapi -I./include/generated/uapi -include ./include/linux/compiler-versio=
n.h -include ./include/linux/kconfig.h -include ./include/linux/compiler_ty=
pes.h -D__KERNEL__ -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-=
strict-aliasing -std=3Dgnu11 -fms-extensions -pipe -mno-fp-regs -ffixed-8 -=
fno-jump-tables -mcpu=3Dev56 -mtune=3Dev6 -Wa,-mev6 -fno-delete-null-pointe=
r-checks -O2 -fno-allow-store-data-races -fno-stack-protector -fno-omit-fra=
me-pointer -fno-optimize-sibling-calls -ftrivial-auto-var-init=3Dzero -fzer=
o-init-padding-bits=3Dall -fno-stack-clash-protection -fdiagnostics-show-co=
ntext=3D2 -fstrict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check -f=
conserve-stack -fno-builtin-wcslen -Wall -Wextra -Wundef -Werror=3Dimplicit=
-function-declaration -Werror=3Dimplicit-int -Werror=3Dreturn-type -Werror=
=3Dstrict-prototypes -Wno-format-security -Wno-trigraphs -Wno-frame-address=
 -Wno-address-of-packed-member -Wmissing-declarations -Wmissing-prototypes =
-Wframe-larger-than=3D2048 -Wno-main -Wno-type-limits -Wno-dangling-pointer=
 -Wvla-larger-than=3D1 -Wno-pointer-sign -Wcast-function-type -Wno-untermin=
ated-string-initialization -Wno-array-bounds -Wno-stringop-overflow -Wno-al=
loc-size-larger-than -Wimplicit-fallthrough=3D5 -Werror=3Ddate-time -Werror=
=3Dincompatible-pointer-types -Werror=3Ddesignated-init -Wenum-conversion -=
Wunused -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno-packed=
-not-aligned -Wno-format-overflow -Wno-format-truncation -Wno-stringop-trun=
cation -Wno-override-init -Wno-missing-field-initializers -Wno-shift-negati=
ve-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-parameter -=
g -Wno-sign-compare    -DKBUILD_MODFILE=3D'"arch/alpha/kernel/perf_regs"' -=
DKBUILD_BASENAME=3D'"perf_regs"' -DKBUILD_MODNAME=3D'"perf_regs"' -D__KBUIL=
D_MODNAME=3Dperf_regs -c -o arch/alpha/kernel/perf_regs.o arch/alpha/kernel=
/perf_regs.c =20
arch/alpha/kernel/perf_regs.c:46:5: error: conflicting types for 'perf_reg_=
validate'; have 'int(u64)' {aka 'int(long long unsigned int)'}
   46 | int perf_reg_validate(u64 mask)
      |     ^~~~~~~~~~~~~~~~~
In file included from ./include/linux/perf_event.h:50,
                 from arch/alpha/kernel/perf_regs.c:4:
=2E/include/linux/perf_regs.h:13:5: note: previous declaration of 'perf_reg=
_validate' with type 'int(u64,  bool)' {aka 'int(long long unsigned int,  _=
Bool)'}
   13 | int perf_reg_validate(u64 mask, bool simd_enabled);
      |     ^~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:290: arch/alpha/kernel/perf_regs.o] Er=
ror 1
make[3]: *** [scripts/Makefile.build:551: arch/alpha/kernel] Error 2
make[2]: *** [scripts/Makefile.build:551: arch/alpha] Error 2
make[1]: *** [/home/jenkins/workspace/linux-alpha-alpha-defconfig___3/linux=
/Makefile:2229: .] Error 2
make: *** [Makefile:248: __sub-make] Error 2

MfG, JBG

--=20

--mslrvrPhqrcBcnNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQQlDTvPcScNjKREqWEdvV51g5nhuwUCat6iWQAKCRAdvV51g5nh
u/SNAJ9Mzo+AZmCGsEYWRkTnjDMxXtk7BQCfUU0klDfb7QJLLGqqt3J0mncTHNY=
=eZNK
-----END PGP SIGNATURE-----

--mslrvrPhqrcBcnNc--
