Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790BBA3F
	for <linux-perf-users@vger.kernel.org>; Sun, 12 Jan 2025 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736671934; cv=none; b=WmmDk+1Xsk9i7sWGX5ET5KX7MsuWzwteImve/aOJy7lh4bm8WcX1bEax7o0+ynSnctxAbTw2U0E1/2bO6kv2h3WE3FKcnyO365DKdNMLE46Q64+mRLQ0ldsWf8aKpwNqvgZV6tVVhdThdr1XWI8hW6Ifmm4lh8c/6g5wIkeJb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736671934; c=relaxed/simple;
	bh=JOMReyovQRb5B6Klu6om2712Y5M5eIhwBDc1eAqm5EU=;
	h=From:Content-Type:Mime-Version:Subject:Date:References:Cc:To:
	 Message-Id; b=F2KCcsgnqOMJlRUuBbSDHMj4ZqjkeYO28RyV9abiOFENg70L28ICo5bEFfEx3s9XaBmg0IVbGXf+Pa2e5GBSUtUfyouvCKgdRPJdYT/TJlADi86+6cIOW50fAftpFChjtK3z07oW+RRBh8eIUEDI2LjXRHzhJI4A21dgcMuGzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b=uKlswNqb; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=m.fudan.edu.cn header.i=@m.fudan.edu.cn header.b="uKlswNqb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=m.fudan.edu.cn;
	s=sorc2401; t=1736671878;
	bh=6yd6T5smdSeVEgpNWXonVwZPx9jWuoNw2qL/pDEWU2I=;
	h=From:Mime-Version:Subject:Date:To:Message-Id;
	b=uKlswNqby3N2DPxmgyAIcFLnXFpW+nthYOzWWrk/1AuZLnKIH+vgIf8D6jebUoKMA
	 J75m5UbJIl4LUz4aaJUoW+GOF2bOfKK+q8P3GYq67pLVAgag6UI9rp6SqSe1pwzmMl
	 gzR0xwar5F7SNjdLUq55MKlC1v+ys7lnahA8ZwoY=
X-QQ-mid: bizesmtpsz12t1736671874tsg7wa
X-QQ-Originating-IP: McbkMQA3GUa5TJWmskP11tMqYlJh6BaGhjJGjwOuBn0=
Received: from smtpclient.apple ( [202.120.235.170])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 12 Jan 2025 16:51:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13410730971932175326
From: Kun Hu <huk23@m.fudan.edu.cn>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3818.100.11.1.3\))
Subject: Fwd: Bug: Potential KCOV Race Condition in __sanitizer_cov_trace_pc
 Leading to Crash at kcov.c:217
Date: Sun, 12 Jan 2025 16:51:01 +0800
References: <4CB5EE98-DA69-4598-B08F-C9F432C68707@m.fudan.edu.cn>
Cc: linux-snps-arc@lists.infradead.org,
 linux-perf-users@vger.kernel.org
To: peterz@infradead.org,
 mingo@redhat.com,
 acme@kernel.org,
 namhyung@kernel.org,
 mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com,
 jolsa@kernel.org,
 irogers@google.com,
 adrian.hunter@intel.com,
 kan.liang@linux.intel.com,
 vgupta@kernel.org
Message-Id: <F16B62F9-6F58-4503-AB8D-47087E973905@m.fudan.edu.cn>
X-Mailer: Apple Mail (2.3818.100.11.1.3)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ng+IY0t5lMbczvGpq6g4LEzRyCz9okFbZ+bnjKh7+GH2nCH951zy3qof
	PIixtq3XThsXC08u2vU0K4GPDk+3FF97+leflL1Umei0W8O+mDyifZqsv7gAU6bZjkgtt70
	waUBDsDekWT4sJYULhbjlIko0JO42/cOuIvZfMxaBCVUoXG2ELqaxtWBecoRvBj2/uI73A1
	1972By9bWloZ1c0s2F//pTbnWv6Eaid09XOJGnPhblhTxGN+Cl8nmBm4kNaI/84qDRdwa8q
	RjCr1mLXsTw/yQ12SrMXqr5Hj6kCAZoUByc5YbhIe2X4Fe3LXDEfmkIjEUTQo7ZXmoGzOcC
	2IWE6/sCmnT18Jkhx6wxGVXFRPN8J+6y+B7k48tl6rovCh1r5YBi6flzTxyi/Qu2hPX1p9A
	VyONyAPzt1T9gK9wdF6PnVTKokXF99ME8bV1ZBfjKAimiHeAXUtg0xmYgEKAN2W28BpYtmZ
	hhEFHD2yl5hobH2pD59JLyFg37abgISPFbpvr64TzgA5WEAgaBtT+vjbInDwIVaUKBF3CbZ
	UH9WB8p3ZHb/nd7tgZxk++5v5PU15pvoJLzGMaieqF56+W5YGOxRq2fJtrIz+Hd4kyL1A0Q
	YT2GS7z54yDfzejlGNwu/CD3d88V9/sIoSKQz0rY3Vp3R62aqv/imklWSQs5NvmKx09/pyP
	4B/9Tn8KBzWK8Y73vq4OKdSnJ3WgXS6epm0roURG9yFUPUzyNH6G+vOHVQDMXJuBM6zNjiH
	Akl1RT6p4ZYmpBVCAJyp43JtVwdP5eIjaIRTTxWPW5Ia7SXKRptJWhVCSGGcm5bXYnYTT1W
	KGL+xpOgqo7aFGWW1Q2xZHxtTe7CJexCoE+K5qymfFr04IyPIBXJxaX00iulWEbtDIJSL3/
	oAKa/dTboFgdeGNEUgF8p/gysNQHS5SusdB+uhrOUuBf7HaHOBtMEUcUQWc88j8IJ8fRWK3
	To/qLSSbJ1EVaij7D0wTqKz2Eg3xkPG8KPzcdYaw0kmyQ1kyYmA/OKoX8e8E6FlYZIojj11
	OW0axYa2CZq4AKY3YY
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0



> =E4=B8=8B=E9=9D=A2=E6=98=AF=E8=A2=AB=E8=BD=AC=E5=8F=91=E7=9A=84=E9=82=AE=
=E4=BB=B6=EF=BC=9A
>=20
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Kun Hu <huk23@m.fudan.edu.cn>
> =E4=B8=BB=E9=A2=98: =E5=9B=9E=E5=A4=8D=EF=BC=9ABug: Potential KCOV =
Race Condition in __sanitizer_cov_trace_pc Leading to Crash at =
kcov.c:217
> =E6=97=A5=E6=9C=9F: 2025=E5=B9=B41=E6=9C=8812=E6=97=A5 GMT+8 16:35:31
> =E6=94=B6=E4=BB=B6=E4=BA=BA: vgupta@synopsys.com, =
Eugeniy.Paltsev@synopsys.com
> =E6=8A=84=E9=80=81: andreyknvl@gmail.com, akpm@linux-foundation.org, =
elver@google.com, arnd@arndb.de, nogikh@google.com, =
kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, =
"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, Dmitry Vyukov =
<dvyukov@google.com>
>=20
>=20
>=20
>> 2025=E5=B9=B41=E6=9C=8810=E6=97=A5 20:13=EF=BC=8CDmitry Vyukov =
<dvyukov@google.com> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>> On Fri, 10 Jan 2025 at 09:14, Kun Hu <huk23@m.fudan.edu.cn> wrote:
>>>>> HEAD commit: dbfac60febfa806abb2d384cb6441e77335d2799
>>>>> git tree: upstream
>>>>> Console output: =
https://drive.google.com/file/d/1rmVTkBzuTt0xMUS-KPzm9OafMLZVOAHU/view?usp=
=3Dsharing
>>>>> Kernel config: =
https://drive.google.com/file/d/1m1mk_YusR-tyusNHFuRbzdj8KUzhkeHC/view?usp=
=3Dsharing
>>>>> C reproducer: /
>>>>> Syzlang reproducer: /
>>>>>=20
>>>>> The crash in __sanitizer_cov_trace_pc at kernel/kcov.c:217 seems =
to be related to the handling of KCOV instrumentation when running in a =
preemption or IRQ-sensitive context. Specifically, the code might allow =
potential recursive invocations of __sanitizer_cov_trace_pc during early =
interrupt handling, which could lead to data races or inconsistent =
updates to the coverage area (kcov_area). It remains unclear whether =
this is a KCOV-specific issue or a rare edge case exposed by fuzzing.
>>>>=20
>>>> Hi Kun,
>>>>=20
>>>> How have you inferred this from the kernel oops?
>>>> I only see a stall that may have just happened to be caught inside =
of
>>>> __sanitizer_cov_trace_pc function since it's executed often in an
>>>> instrumented kernel.
>>>>=20
>>>> Note: on syzbot we don't report stalls on instances that have
>>>> perf_event_open enabled, since perf have known bugs that lead to =
stall
>>>> all over the kernel.
>>>=20
>>> Hi Dmitry,
>>>=20
>>> Please allow me to ask for your advice:
>>>=20
>>> We get the new c and syzlang reproducer  for multiple rounds of =
reproducing. Indeed, the location of this issue has varied (BUG: soft =
lockup in tmigr_handle_remote in ./kernel/time/timer_migration.c). The =
crash log, along with the C and Syzlang reproducer are provided below:
>>>=20
>>> Crash log: =
https://drive.google.com/file/d/16YDP6bU3Ga8OI1l7hsNFG4EdvjxuBz8d/view?usp=
=3Dsharing
>>> C reproducer: =
https://drive.google.com/file/d/1BHDc6XdXsat07yb94h6VWJ-jIIKhwPfn/view?usp=
=3Dsharing
>>> Syzlang reproducer: =
https://drive.google.com/file/d/1qo1qfr0KNbyIK909ddAo6uzKnrDPdGyV/view?usp=
=3Dsharing
>>>=20
>>> Should I report the issue to the maintainer responsible for =
=E2=80=9Ctimer_migration.c=E2=80=9D?
>>=20
>> If it shows stalls in 2 locations, I assume it can show stalls all
>> over the kernel.
>>=20
>> The only thing the reproducer is doing is perf_event_open, so I would
>> assume the issue is related to perf.
>=20
> Thanks to Dmitry,
>=20
> Hi perf maintainers,
>=20
> We reproduced the issue for multiple rounds.=20
>=20
> Does the frequent occurrence of perf_callchain_kernel in the call =
chain indicate a possible problem with the call chain logging or =
processing logic for performance events?
>=20
> We lack the relevant technical background, could you help us to check =
the cause of the issue?
>=20
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94
> Thanks,
> Kun Hu.
>=20

