Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D34198A2D;
	Mon, 17 Jun 2024 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632028; cv=none; b=caAl0QS+62DgV8slR1dDbpVAJthZUS0yL8G1OP6QtTH9KV8H8oQwA7YiQCBek+WifCDOdr5GOAGtW1OrV+d/R6poiDX0WDVG98eGBeSpn6qz4hkoUNOGAOiB2wWWhQJkcUADhhmefqACBn1xky1fHk4cbuCeJZH2kdXkbcXGLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632028; c=relaxed/simple;
	bh=2NB43eu1ZnhJn+dbsU/poLUXcczLkoG/+P5pzf4DTBE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UU/M2TZElNS1j87X6luaYBaFR+EC01REyEUMI8IdiPwYTn4IUS/FXL2dns4DkAUsR3Xbu0C1HyJUEat5ZNesJxYR5J8TY/q44Z37BsYK3PlxJCyf8x826KuAuUp9udbYmnMg4YDE5pYVnFxEmlgIXZ24RrFd9ngeI4tL3Qo3cyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=oQTxDdVQ; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="oQTxDdVQ"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45HDkTn01572680
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 17 Jun 2024 06:46:30 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45HDkTn01572680
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1718631990;
	bh=o/p3WriqvPQ9emXsAa+PuJT6Sy/sb6jthDAPSr/Ca1s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=oQTxDdVQK3GcDy9FfiD30CnOzinaTHDW0AaA9TyFPaXQGLqX9qfnPs5uOlZKw0t18
	 ln64nIOmmerDa97WyjSeco3Dg2Wyj/ZY3oV2t2wEKlNoe9iHlEHAOvgvsJWjiYJ7x5
	 FCdK5WvKksNmdgPXKYFchMHwBtnbbq7DcT+JLv7Juy8uDebJ58wdIisiCp7meHBJV6
	 SOKq4y3M02x0BEa4g3DWEoWFOu2Rw+aPYNIWGdErPqS4a9GM6CWkQaXEBHyoKhcmEu
	 d1t8joXMZscFO7PSaHHkEKAtxsxNcVB699tiwvYOG8k18WKDKZ7HgAU24LxhlpWH3U
	 +DbLJlkTRr/KQ==
Date: Mon, 17 Jun 2024 06:46:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
CC: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, acme@kernel.org,
        namhyung@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BRESEND_v1_2/3=5D_x86/cpufeatures=3A_Generat?=
 =?US-ASCII?Q?e_a_feature_mask_header_based_on_build_config?=
User-Agent: K-9 Mail for Android
In-Reply-To: <99208d95-d3de-44d0-8b08-f508759aabca@zytor.com>
References: <20240509205340.275568-1-xin@zytor.com> <20240509205340.275568-3-xin@zytor.com> <99208d95-d3de-44d0-8b08-f508759aabca@zytor.com>
Message-ID: <8F9E89A4-B05B-493C-8BED-52AC6777D915@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 16, 2024 12:26:48 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 5/9/2024 1:53 PM, Xin Li (Intel) wrote:
>> From: "H=2E Peter Anvin (Intel)" <hpa@zytor=2Ecom>
>>=20
>> Introduce an AWK script to auto-generate a header with required and
>> disabled feature masks based on <asm/cpufeatures=2Eh> and current build
>> config=2E Thus for any CPU feature with a build config, e=2Eg=2E, X86_F=
RED,
>> simply add
>
>=2E=2E=2E
>
>> +
>> +		printf "\n#define %s_MASKS ", s;
>> +		pfx =3D "{";
>> +		for (i =3D 0; i < ncapints; i++) {
>> +			printf "%s \\\n\t%s_MASK_%d", pfx, s, i;
>> +			pfx =3D ",";
>> +		}
>> +		printf " \\\n}\n\n";
>> +
>> +		printf "#define %s_FEATURE(x) \\\n", s;
>> +		printf "\t((( ";
>> +		for (i =3D 0; i < ncapints; i++) {
>> +			if (masks[i]) {
>> +				printf "\\\n\t\t((x) >> 5) =3D=3D %2d ? %s_MASK%-3d : ", i, s, i;
>> +			}
>> +		}
>> +		printf "0 \\\n";
>> +		printf "\t) >> ((x) & 31)) & 1)\n\n";
>
>This code generates macros {REQUIRED,DISABLED}_FEATURE(x) to tell if a
>CPU feature, e=2Eg=2E, X86_FEATURE_FRED, is a required or disabled featur=
e
>for this particular compile-time configuration=2E
>
>But they are NOT currently used, so I prefer to remove them for now=2E
>
>Thanks!
>    Xin

The goal with these is that it can eliminate the handwritten code that tes=
ts a long list of masks=2E Again, automation=2E
