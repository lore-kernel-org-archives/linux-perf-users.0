Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6391C6FE0;
	Sat, 15 Feb 2025 14:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739630185; cv=none; b=WZNt1YpdhnmzSxT6GgWNzuA4+HsSNpo39nxrwIIzFikNoAnnLxA/UDW73c8OtYc1dpgWTXyfVtBIGIFRU8dPu4tX7KNTsF7kAx19hpCbPPkpLeSeCe2DkeFsD2htfJbpAbSk1uTUTvOrBONpxRUuFn0RdDfSWy8sZH2aZ/a2H7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739630185; c=relaxed/simple;
	bh=uEA82nIERq231zio8YAHm1zQb3lpFmWuNWHEI3vc4YU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=gwyYqVD1pMZ3qDaGYRLMWe9O8iMzQEheKyl7UZ1gmK7gA3v8vgIyT2pRO0Q3pg3BEhT1mtFgFQiMud+5G1zgUoVl8CTnmZrhRpIkN7uOzjFqYyRgveLPYznaQPsANqLY6NAf8SQSkUumqGC5peOGtHhl9f4E7Oum3TlfNkMKq+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=C0bXQ93y; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C0bXQ93y"
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51FEZrnY149497
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Sat, 15 Feb 2025 06:35:53 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51FEZrnY149497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025011701; t=1739630154;
	bh=uEA82nIERq231zio8YAHm1zQb3lpFmWuNWHEI3vc4YU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=C0bXQ93yUCfsb0rgX4pjR1S/ANuIVIdQdfgjmJ5fefeXe9MslHJEnuzYzurRoeOJx
	 VqR4MShFjlnYqCiMHkrBYncHYis0LweyslwIlrLIHo2JHGymMMHd3Qyqb9QUV/aH9C
	 88QYb2bJ5iBpbJiNmhnSiensG6wC1q7aHVCCQGaIcD181lt9bw/XBqqdGDpXIsWgEX
	 LZw5S5u3hQFh2I0hMGT4N53r6HIFu4mhvDAav3DXAmIuRn/0e8Z3HA2Y8es8wC15Dx
	 fhJX3JfQeFL/COWRGyNbdRL9QKviiPPrXjMXPXG1DfxAgBAzIsnIo8yCY8VG+QJUEz
	 Dv1j4e2f03yeQ==
Date: Sat, 15 Feb 2025 06:35:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>
CC: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, will@kernel.org,
        peterz@infradead.org, yury.norov@gmail.com, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org, brgerst@gmail.com,
        andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/5=5D_x86/cpufeatures=3A_A?=
 =?US-ASCII?Q?dd_=7Brequired=2Cdisabled=7D_feature_configs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250215143032.GDZ7ClCJzyDkuvQSJp@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com> <20250106070727.3211006-2-xin@zytor.com> <20250214215823.GEZ6-8f5wt--IWggtl@fat_crate.local> <469D0BEE-76D6-4417-B5B0-0054D3F96784@zytor.com> <20250215142017.GCZ7CioRHgpm6a-eIZ@fat_crate.local> <3B96E82B-7AA8-40FF-9401-829D408AA790@zytor.com> <20250215143032.GDZ7ClCJzyDkuvQSJp@fat_crate.local>
Message-ID: <6187A454-B995-45A3-8356-ED7CBB4E478F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 15, 2025 6:30:32 AM PST, Borislav Petkov <bp@alien8=2Ede> wrote=
:
>On Sat, Feb 15, 2025 at 06:27:04AM -0800, H=2E Peter Anvin wrote:
>> The point was that that is the *only* use of this particular flag, I be=
lieve=2E
>
>Now you've confused me :-\=2E Perhaps elaborate a bit more what do you me=
an=2E=2E=2E
>

A bunch of flags in Kconfig=2Ecpu have exactly the meaning of "this CPU is=
 guaranteed to have this feature=2E"
