Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6351F63D9
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771328860; cv=pass; b=tjb6bjjUDF65RQrQQv8WcgrF8ku/jcRKrx+xdFmwPOTaB/IMTbmJlrX0anv+vMmPMlVCKgZExqPwJAgH/9JfIce8tCbRRPeTx8GW9D2xf5uFSKVDS5So1j3yFHc8vY3RUcu+CbJQsAbAxmeyqp3gLmrMBCIIU+ksfrHVif+Krv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771328860; c=relaxed/simple;
	bh=uiNSC2DAZwGhFEt5BExjnNelEqGuXEMpOdmPQR4w7v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUu+suS5AsLqANH6qWXV0tgi+nhvvvoy3dRzF0i1mJLKXUGltJh1OSuD3XD1UW1ETLQjgHXjNoFhakOGahtAksexyVIFOtjVKkvVEY+mGawN7GM4twqa6y6llLiXqtzPc8AI+9OcRJstyacEVTv9E2b91x0ogdjUFDUPwX3AR1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7F4sCte; arc=pass smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7F4sCte"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-40fb2789476so1486047fac.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Feb 2026 03:47:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771328858; cv=none;
        d=google.com; s=arc-20240605;
        b=CZLEp78/dY2vrETYPbpj/HieXRyvMXToAByerM+zWlR8QabOAV6yoyvUiHWQv+PB+m
         oPOPaqoM2pLRBnQTg4c1nlI6zKDRVHQHVqz1Fkwz2XOT7pzrcnKFHFGwsyrC7cuUdUI8
         CnTdADf5MHAO9FZHrFkuu9cCPTPzoRikjBDUDvHYZMJmDlIAeJODNKs6FOApUsNw7sSL
         S7TMoNk+J5sLtP4K+PbM3Tw5YoT0yVZvKS5Hjsm7S14Cc+RehMw5vNyhvrD3XLIv3LE5
         7xnLzFv41DDlnrysixCx91+oQTofqr4Mo1KSpVDaTVbTen+KlztjPSUuzCv43pTGIxqQ
         Oq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6RNRXWErqKixOzdyNw8jzco1B3FCxwMoWupdWpYQueM=;
        fh=UceVnGrXASSekfMbBkLtvWAHNtvNe9ud14/JoiOc4kM=;
        b=KtQCDOH9WBaIiQCJJoBYFJUxL1l175zLRlqq38fWDCZpqsu7kvGxusABX9iQgIMNmg
         TykVp9lQm6tTcuARO+dT/1pBJ/NRXlY3dM5v19tSQP8jseglbFdrsoH3GD6HqTQ0jdPi
         Ew7QaWl5zq1FOpHdyCKIdJQReI5ghsJOmDwAAPA/z8s0vdarwQhJRlVvRx6TyttkK/0o
         rEU6zRMPLW+DlAwutQAP431VIklJgzt7aThxUGSLs4MYUHZH3d51JQrwnt1B0jNdPOP8
         UbXP700ge/MWaIJqhacF2D66PNXx7bIT+gBKvzAXboJCfm9lLrSWCC5+MwGuoGWKqMvl
         HT1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771328858; x=1771933658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6RNRXWErqKixOzdyNw8jzco1B3FCxwMoWupdWpYQueM=;
        b=Z7F4sCte0l0yd8ga8r7xQgaQ1WJsZqsTapHkm5ojofrabCsgo2AJcPntIG5sUc/gG0
         VUrtZkMK287gy58d/g8ZM3zy6CGsdKLWyxf6e8OOZ30seJsX36dHyBhWHYyGS3UfzABB
         cjJasWB4SDwaHsrbmdJtTh3N5wsV6K4kR0FNilLdJKGRmC1RKh1glqeGo05ej9uHCB3o
         2Kgy6KtoHQYCYcpzm0yHswdiSdPXihJ9H4RgdLHFDp4lHysJmcbluKlRVYrUdSzoygmw
         oFFB0PQlC2ZZ0BSIcEikE2FEnXUJDJvGLHEqzjCZPBSRHChW0pvI7CsOcsGL4HAtkOHz
         wIXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771328858; x=1771933658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RNRXWErqKixOzdyNw8jzco1B3FCxwMoWupdWpYQueM=;
        b=Y8arDiQskZb/eQtsaCIYLxcRLlsl/B+Gc3bLoQ07neL6PKKSVL0GVgO1TqO2YvgYwX
         MAPVbs+jVMAc/lo2FbGkXy/I1E+jZvYDRovgu+zE6MxByVkDIMhQcr59Bkq+ofAPV8TC
         V3dyX9hYExDqlVE5Vb2ZhgArHUBAgHhADOyxcAiPaCRrbWr+FrylKCGYlEkAks6FdviT
         qC2bOvZFrSyxZ4rrQQuTZitCmosP4+Tw1U4JOtcPIm5YIPOmqggZrDxorD+bjUr/iCSM
         qT+e+0n/uEQkaTiFn36QJcxxQbcqI/w1frcrDwxXCaKwL+O0S0Zuc27Yq4pLhL/oawGo
         CBZw==
X-Gm-Message-State: AOJu0YyKLsQae+jO879tDCaublDoqfUvRsBMrXxsMURf/f6VPbhQgFFP
	/XAQMw79s1xu4sflqA2W4ut8Ptu1J0MOzALeFft8Vm4ao4J8KIusFpP9W0et90oAX9e8+OfUf6G
	tl+AmV0Cf4CCmwXk5unT3X8p+YJGrChQ=
X-Gm-Gg: AZuq6aJ9v4ESplrGg2Q17LsEMsB86zRupEda0RRsZ96A7j3VtxoLLztK4JmRpeITgBa
	cHw7uj7GNb3EgEOFsJ3kODpSK5rFMdVBXW2bAoCPZKydPkyoWTh1C6SKlacejC3LwvWMGjZK/Ni
	ymJvIiWPFqi1vhYR2ycVq/Odai2JpDZhM8eJcMOl8RznPwgHzfD1fSUWDUQrKTBP8UzK3r+EgLX
	6DQLNsQiH/egfQRwuGYQH6JeTwDdUH39bXtTAiUqHsJkBTvnyTfylDPnRevgL1w+QWF4C8iPvd7
	xgB1agnulA2LIrJDfnCd7ZjGg65Uo3kBZBtO7ZPa
X-Received: by 2002:a05:6820:1b18:b0:676:7a1d:2c57 with SMTP id
 006d021491bc7-678221cdc0bmr6139844eaf.19.1771328857941; Tue, 17 Feb 2026
 03:47:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYHVnXddP=V-q=0Z3Na1FOBaQRT3RA55ruDY=O0pNpbaSc4jg@mail.gmail.com>
 <aYo334TnekI8UgpY@x1>
In-Reply-To: <aYo334TnekI8UgpY@x1>
From: Noel Grandin <noelgrandin@gmail.com>
Date: Tue, 17 Feb 2026 13:47:02 +0200
X-Gm-Features: AaiRm51YjVxV33wjqUe_7dn_ugDja9aefiZ7lGttAitfv0cOhRIj1Y6bpAk2_Es
Message-ID: <CAFYHVnV8h-ZcckoYKER127U5cYvvsye0iXfgQ2aA0ddr_ivrTA@mail.gmail.com>
Subject: Re: why is 'perf record --call-graph' using addr2line?
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Feb 2026 at 21:39, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> Are you sure? addr2line can be used when using '-s srcline' or '-s
> srcfile', but then in 'perf report', not on record.
>

Yeah, that is what confused me too. I can see the addr2line
sub-processes show up in ps.

For example, if I do ps -ef, I see stuff like:

noel     1259058  199773 10 13:45 pts/4    00:00:01
/usr/lib/linux-tools/6.17.0-14-generic/perf record
--call-graph=dwarf,32000 --pid=1258658
noel     1259067 1259058 42 13:45 pts/4    00:00:01 addr2line -e
/home/noel/.debug/.build-id/40/d2427b70abca4c5530fc6abe4b64acfe039146/elf
-a -i -f
noel     1259068 1259058  9 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/99/2e0e9c5b545f70d957da48ca4fa0062cc086c9/elf
-a -i -f
noel     1259069 1259058  2 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/71/9539027bc2d800b08810a3847206e283f8f347/elf
-a -i -f
noel     1259070 1259058 22 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/38/2eb792f7961162be41274fa3c1aae864f9cde7/elf
-a -i -f
noel     1259071 1259058 11 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/ed/fe3aec8836926683342a0efcb4d8e44eb8521a/elf
-a -i -f
noel     1259072 1259058 41 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/e8/fc08b1b0ce4130c26f40b13470d484fc2f6f55/elf
-a -i -f
noel     1259074 1259058  1 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/f4/8422093b1a8f666e0ef64ff6a3842d83206274/elf
-a -i -f
noel     1259075 1259058  2 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/55/43d41f3e8e476763d436e15d5a8e287d7ea677/elf
-a -i -f
noel     1259076 1259058  0 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/74/eaf539c3959f449ac8bd93ff882cd7b2990290/elf
-a -i -f
noel     1259077 1259058  5 13:45 pts/4    00:00:00 addr2line -e
/home/noel/.debug/.build-id/8e/9fd827446c24067541ac5390e6f527fb5947bb/debug
-a -i -f

> Can you give more details? Do you have anything in ~/.perfconfig, etc?

I do not have such a file.

Note that in this case I am not doing system-wide profiling, just
profiling a single process.

Thanks, Noel Grandin
