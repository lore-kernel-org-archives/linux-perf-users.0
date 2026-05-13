Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102813B5851
	for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 23:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778714052; cv=pass; b=e2xIApHSFNMHfhZlFlulZsS0rm/LfoOzP3KzypFLTAyMPZQ8ECiOqGtVFXLr7Z/HDUuOyLQRPTvLMNCzG0ZxRcQx97zh/muQ9eh3s9H8Bj1T6pIgurJ1GpEX92aR31yFenFBVw4u11yLf8UHHKucn4cy8nf2t6KKpoYg+z0qI/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778714052; c=relaxed/simple;
	bh=luXF7+GiEy1MMW/NKgxfkqQbzQ425H+M0/VeoJTQkNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VwoXPnCj7S80m1iQxsgO1uuHR0x8rR6I8JMqi1Bq1FVvarpXJd0d6hma7FlQretJ8ZtCKfsSVK7QDr2wRPU8E3IrwgTdbyGfFsm8N0P4K+aJjSaOHiEqKoEetqMfmsT9FG34HyXHrDkbiMGA6mX3crg3x+qf7CLm6v91wLWJ+4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PI5xbh8u; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PI5xbh8u"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b46da8c48eso13775ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 May 2026 16:14:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778714050; cv=none;
        d=google.com; s=arc-20240605;
        b=Gmt8OXGdRR199uOtfhc1EeobA1+Vb7npYHuCwc27g1WXRcl4h0glsSNdNp+/DimGoS
         Vq66YHBlj8FhnpJTQEn1IS+g5H+fjMIGndGt+k8oLGRwckplU39D6zYePr+UAzoCb9Q/
         2yjMqubjI0xgJ5prN/KDoLBbd2FsHzNPH54hm24Fpg+mEojd7lFFfFyDhalVFl7m1GZo
         kkZew/elPJIu+lxSO5Rt3Eo3al5Ohabu4jmCOXZVn6gG8vV1BPdnudb3oPbNBfYBvx6p
         5AdbR1Yn9wuCUKkEhd3q2lhCbRDQWdxt05TpomvRH9f2HVfTfZ6XcKBYVUTPzZxtId+k
         Ow3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=luXF7+GiEy1MMW/NKgxfkqQbzQ425H+M0/VeoJTQkNk=;
        fh=IPLoE8JV/Sn2RAzF+Ld327ojdMSEj5NNVWypWTp1rJE=;
        b=CBNbZYsL5rtbEPg7fjT29oY+sIvFk+U0fuPrO0ohuU+lK0KZ6OpgPnV3oyCCUlxe8t
         vWtfZegTVQr4b/QtaNK/o/mGN5L5AxUwVTpIWoVGYg5HbH6B/2dLcbps6QzZ7sUJaufj
         PtFG0UvJ6qnYSqKZW8SNz94bhJ4VddgWvnewU8kxPeo+1kui53UTsUczFkAFYDZPJJQQ
         BUbuqcjYctRQW50eJ3VM6ktb4M0SmPc8D0syppMyH3zqk+4Lz4GtZkXurPjYw2djpUdA
         Xc3XfbxPe7jDng4OJgIAfQ1ziEsdHrss9Fw/4fE6xhq64qhfY5SwO7OJB5KzltKRjRJP
         3z+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778714050; x=1779318850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luXF7+GiEy1MMW/NKgxfkqQbzQ425H+M0/VeoJTQkNk=;
        b=PI5xbh8u/UOWdVydIkjumFpqMHTyZGX+91EF6vmeaXrNS63aQcNbNCS3v2Rdp3qWco
         TVc0sudZ6FFbz9BnZSC/ZEU0Zy0YCA9eqMzzeebK10y8EftXoLuWsPf0H90MESmK5XP/
         LcWPoM53zZrDJiTA/weH+3wK+tmIJeWURiTdXhuntKEUtwiGZVNBYpZYcgtpcoa/sxtQ
         sLgrl9vznTCoiEGG4AuGw0CnXltu9BsrAT3x5vmcqpOJNHk61WukXtC9zj4znVmZKv8W
         oUsq1rz3Hk5Hu7+jWA2oKztBpxyi3RLS2YWME1iS12dAEVvUMmULOP/dzrad5Lvzgm3n
         ww7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778714050; x=1779318850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=luXF7+GiEy1MMW/NKgxfkqQbzQ425H+M0/VeoJTQkNk=;
        b=mWvS7nsxc4WxlBbgQPpZAFDDqX4yBROOKnnUgKYHa3wFxlr9f9ctONAkZZnYXmuzCh
         OQq7upP327xrsJiydYbOWGNUX7yPmgFs+XefkTc+0ZNabSjNP80LytEWL41cMJpZlKVi
         DO/fREC6M5vPCBSnzQ+fbN/+ON+NEoDpCqT69BCN2cwjx6dgA0nvmYcHRp9Dft/501X4
         M7HoumxmpP+mr7UH30fksYGwcVsXPpAp/OOL5u/lTgNbhi5+vRQuzwxZBoJwQC0vh+HL
         YuNdr2PP582nYmANlVANS3ANUWzvjHInSaDyKJVF5W92eEayqEdx5+4M7JS+n8ViYXIM
         QKFg==
X-Forwarded-Encrypted: i=1; AFNElJ9MgQPBVh8qfJYioUFqidSqQdj6gX8S4waE+HQw+FemDlFilXx5cvNxN5kkQXhiq52eXVmNeItnzO3h+Wvpiz+N@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ggtLXGvDWz/IJKTr2NP1o5c39QCn+5T/jifuSlV12CXuWxSl
	KJZ4a1udvRvjJ1alrCyGi4bIC2QniFktZtUQ/p0/a/E7tLfvz54TKu1AunGVRC39tnPlCNBgN3b
	sJMhTVgxMiX134GQ+WqjUqV26I83ebG+WU7wFEzLB
X-Gm-Gg: Acq92OHZYLoKRmuvaAFTwiswvjg2ACGmYYrvUGG6eB7KNzBg51XkyaP2H6ZWzHbLgt5
	Ra0mZsbFMvdz2tYDxsHF+u4zjZg1Vtqg6e24skPOEmS+pQlO9Ozjl/ZWKRjsEh6PHfhXLHi1ePW
	KumjwN+A/zLKNcM8hjy5nPu1GGH2WDRG6McnZmrIbS+ThbRQfORBnojuszkK0sLYcgPaPW23cj9
	L3uz5bCDSJzie3oUm0qpnusWBGaXxZLJPtu/cJYPuFWgzBm4Xsycl68bRC59yzXfhhnJMclFZCw
	j/C7jKqIq2BZEUhUdRVs/7CptyTpcqdGNrnlqKaEtiXjVE8=
X-Received: by 2002:a17:903:1b68:b0:2b0:aee4:afe7 with SMTP id
 d9443c01a7336-2bd55e466bbmr1481705ad.10.1778714049550; Wed, 13 May 2026
 16:14:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513192347.4007895-1-florian.fainelli@broadcom.com>
 <CAP-5=fXfD5bkhoufpa3aYU5mO4YiJ3agjG+vyB6KUU=o4vGADw@mail.gmail.com> <f06b4732-33f4-4457-9e6b-58ede7590122@broadcom.com>
In-Reply-To: <f06b4732-33f4-4457-9e6b-58ede7590122@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 13 May 2026 16:13:58 -0700
X-Gm-Features: AVHnY4L9wqId2q0g6CdMngrHNBICuQjE-uOQNW1NTZ33R05UbAt7aovZTU4I0kU
Message-ID: <CAP-5=fXfwAXo1_FyS=ZZgtBaP0o5QNxz=1x9EFz+m+4gU8tnZQ@mail.gmail.com>
Subject: Re: [PATCH] perf trace beauty fcntl: Fix build with older kernel headers
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-kernel@vger.kernel.org, mmayer@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 2:56=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> On 5/13/26 13:58, Ian Rogers wrote:
> > On Wed, May 13, 2026 at 12:23=E2=80=AFPM Florian Fainelli
> > <florian.fainelli@broadcom.com> wrote:
> >>
> >> Toolchains with older kernel headers that do not include upstream comm=
it
> >> c75b1d9421f80f4143e389d2d50ddfc8a28c8c35 ("fs: add fcntl() interface f=
or
> >> setting/getting write life time hints") will now fail to build perf du=
e
> >> to missing definitions for
> >> F_GET_RW_HINT/F_SET_RW_HINT/F_GET_FILE_RW_HINT/F_SET_FILE_RW_HINT.
> >>
> >> Provide a fallback definition for these when they are not already
> >> defined.
> >
> > This seems fine but the commit you mention was added to Linux 4.13. Is
> > there a reason you've run into this problem? The oldest active LTS
> > kernel is 4.19.
>
> The toolchain I am using is still on kernel headers 4.9.x, I am
> cognizant this is a very old set of kernel headers, this is specific and
> unique to building for MIPS, our ARM/ARM64 targets are using more modern
> components.

Sgtm. I have some libunwind clean up for MIPS that I'll add you to, in
case it is of interest since I can't test it myself :-)

For this patch:
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> Florian
