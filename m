Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BFF199E88;
	Tue, 25 Feb 2025 18:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507045; cv=none; b=pNkgdHX2DJ++xM2gOzp6kglCm650Ey+YKmYqQ3DY//0IuEhiszIjCwKJTKsqglpaCHz90/NaU5kSP0hofl6QKmckGpSAHZO33WnUL+jEVcyN8mqQz5smojvJJ/kcS9jbZlr5uhJgjoq/maieI/PCBD32V08le89zXi36cE2V/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507045; c=relaxed/simple;
	bh=QTZLuCuhfSWV3Z4wszthnMUFp3B71TOx36/COfQlT/w=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QqeQV4ds4UH/QHYfXvdWS1sBJNPtr+oL/zP8uhkzSocHeBDLgR7y0K7VLnk0DlBAnCru0LoObEoqRSgPkreN8Yohz11dnz9P0yAzSTHbdKbQzFvk0T6Fk13MSF/R7CnVigj6lgf0wi99mCkPJV+sGEmPIJjrA42iwDYmVUjvA0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=wNNGjqz4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wNNGjqz4"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51PIA5JR1380275
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Feb 2025 10:10:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51PIA5JR1380275
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740507007;
	bh=F60m0iCyIzI+vMniVHY4Tn5c8XkNN4GK+Fvq4OTAdpc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=wNNGjqz41V6E1zMgklEVzv/UMNYv9qz6Rf6dk733AUzrUFoRe/ZxfL2LUQOR9p6s+
	 U+RsPneEwyaXM8i+GD+EIobfrhp8P8XTyKlCGZPdmUeXpgIbNZ3jgDTBOfoi0dus5x
	 wObVVoFq5z/AgVSK0qKjysK3CDbXk7btSw/oTzdflg/Gm6rRypntreJOyY/rKoFNvU
	 aT5a7eYbXC/ZPuPxrVJktEQnsJSRkrasJ7RIQ6vz1fWqMgfraFqe51YE3F9aGZ2Yjm
	 2wl8piqpD/sf7IBSYVwBl4iGGeCr+6kxDF43ydOd3bBASptOvwiz+AEETGkjGBqyrV
	 l6PVLTAxtdg6A==
Date: Tue, 25 Feb 2025 10:10:03 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Nikolay Borisov <nik.borisov@suse.com>
CC: Xin Li <xin@zytor.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, yury.norov@gmail.com, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_0/5=5D_x86/cpufeatures=3A_Automatical?=
 =?US-ASCII?Q?ly_generate_required_and_disabled_feature_masks?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250225180051.GCZ74FU-PrcosEHZb1@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com> <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local> <1a444a2e-75b6-46f9-8f38-0458655873ac@zytor.com> <20250225174915.GBZ74Cm2Xpc_WwS3oe@fat_crate.local> <8973bfd4-d8b2-4dd7-ae1a-3f685dff769f@suse.com> <20250225180051.GCZ74FU-PrcosEHZb1@fat_crate.local>
Message-ID: <A8B4322F-F298-406F-8F84-9151FD3CEA5F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 25, 2025 10:00:51 AM PST, Borislav Petkov <bp@alien8=2Ede> wrot=
e:
>On Tue, Feb 25, 2025 at 07:54:50PM +0200, Nikolay Borisov wrote:
>> But don't we use perl even now:
>>=20
>> $ find =2E -iname *=2Epl | wc -l
>> 55
>
>You're searching wrong:
>
>$ git grep -w perl arch/x86/
>arch/x86/crypto/poly1305-x86_64-cryptogams=2Epl:1:#!/usr/bin/env perl
>$
>
>That's some crypto-special thing=2E
>
>This'll force it on *everything*=2E
>

Yeah we had that debate back and forth=2E Although I personally feel that =
any sensible build host would have or be able to have Perl, the consensus o=
pinion seems to be that if it can be done with POSIX standard tools or host=
-side C it should be unless there is a very strong justification to the con=
trary=2E=20

I guess at some point that will add host-side Rust, which will be fun sinc=
e that adds the whole Rust user space runtime=2E 
