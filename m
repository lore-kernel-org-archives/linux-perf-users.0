Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556683B4EA4
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Mar 2026 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772816009; cv=pass; b=lAYpjsgYgwZOutLkb+veZgc5BqEkyar6I61FlBn3tqZUKfZUMXb4JMyKkyBKFZlkutY6QtkTRCwii2phgP30FI1zN6WLu8YRtPimccnvZPOa/LmxDXRnyrx6G1riZrgU1I26SectrSL/98vTNfjoIZMcxaNgt8ncQC6Fcdt3oVE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772816009; c=relaxed/simple;
	bh=uvJAJqJ+OUG+8Qc6KivjDGtBu8adoepmT7qHr235oD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1TyySIQPrv6RA2EtbLiYQPgSZBpcHal7ox5uqUEzD6EVvsy1C078Ifje37HCYJSmIXN2yo2tKMHtNxyzzeqjF5W7FlsLcU7WXxSRPlANS+BqAOmLV6KY6ECH8zoDjHZ8QVWKKMMlBPJS4XP13+8nabH+rgkGi823/y7Y+qI2Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+8xlYrT; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+8xlYrT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ae49120e97so102065ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2026 08:53:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772816008; cv=none;
        d=google.com; s=arc-20240605;
        b=AR87oF9B7kR0UAby+zpEwn5ROQ3AfUyfJHDtwu57J/xCbpkyX+KHcCrCXpxTzVurIX
         8YsgJiUm9t7FkrEsxIsz8K0t3gHG7Q2/8p9kzJCUa/+1rL6Untl86eq8s1Y93V4WVhZq
         GBljKH4/HTT+Gjfin8EXGy7yLr4AVFSrdOqfA/mNtAtIROxzY9LpQFILLwMR0UBuk5QP
         NdTl4mPlBL9W3LFGUJOpS/8GhNAwSFNpXcvhKsqetG6HuBgPgD+UpxaN6IhkGJctb1wl
         Cp5wVve6yirrpO5osqH3mdJ13u3WP/1NOY4UGq/pYC+k9nTueGg6TrpGGqP+/LzSY1lE
         X6og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=933sEyemrbKBxApG2XPD0d2uPjKeHtvt7oVBd4xEr8I=;
        fh=NFaLDVAoNQgvlGnsAu639cv9rEFB875S3iJEyFya+PE=;
        b=GIKvkhXOqbHXlu6FH5CnGmYx7pDoIanamtJk6eAC9Rzea4JyywwbhWE2mxzOVISRdK
         xLXkyuzBOIXXuBNQdl3NzYJVvLf/jew/fpmaNPF9v0IcbMjw7n44b+WukBiMhwE+/bjo
         nO4ClcImMhPll4u6b152x+FMYcgL12Kt7AsnMDLz4iuN0QjUKaM7pnOsSUbFtTiB4r3l
         VAXug+v8JJ/s4E+MxsVggfWgdcc8/NEwfb3EauDo72DZPIQeGZi2eAksoFTUvDtCokOD
         bzYG+Lw1RS3CPCrmyFohYWqAjKPHHtz2ULpp//gfWx8yUm2Zd7vCELtoEMGXl5cYPgto
         +4eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772816008; x=1773420808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=933sEyemrbKBxApG2XPD0d2uPjKeHtvt7oVBd4xEr8I=;
        b=b+8xlYrTITiYbj80vcLrufR5Z/yneu9x9IgtJPoEjTUVRs+B3dhuMoEIE6XJ3HH9QM
         CIPpgLGAObu5xZ1/CcciTrhiFi/VbjC+xMPFktDbgntRlVI3B8qvk80D4vpzV+GXdklh
         TeYjczm0nvRz1pG6rhYo3F3+5nNJDsK17hM+OJnNc0GYUaAzxTJ6wNQ7aE/D+c18vxCe
         XiTcJsMYJF9Kd0ZrLH89Y6+bkOo2cDSIYvA6vjTY0LXDmi5KrZ4j5NRtPFDCyvNOe8+y
         WqIj/gkPnGoHbi97KQ0s9fo1B2b6SwIECLEiGKNBTNM/u07v8xdLHsPbHL/RE6kp9YSZ
         p8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772816008; x=1773420808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=933sEyemrbKBxApG2XPD0d2uPjKeHtvt7oVBd4xEr8I=;
        b=hN/2cr2UiIzW9gk1vBeYrXkY4FGkm2UlxaoubXZHEs4JHDjUeB6NrdnyvYgJh8FXrw
         jiJw21MuAGo0N+u//0f6LtYkO2UA/q+ZjEcUBiUAxrVfAOeyjz0iEPE02M9CccEh6xA0
         qg2Xjr+yE1yCvCDULXDoByN4A8MGw+paXPfWKiMh8MNuGM5BIkXl9HdBngUg3VIUsh5I
         ZF39LNvsc0x9befRfeXfi3oaieCbgJfPy13TTBYQW6D6JJyUAba2pAzBq03N3pSbp4FN
         bu6QblR0USsnra669BxfNzzJ0UiQkoCrxp4LctOKxFOq3EOyecxaTmvKK/pDMdK8/qzN
         2gxg==
X-Forwarded-Encrypted: i=1; AJvYcCW8jghIHwGag3Gwd5DX8P96Yzj8ZT0Z/M3LEmB9y7mTesNZnWtKJ1Cdi+zxREEF95W3Zi2y9z4F4wDY8uwU1kO1@vger.kernel.org
X-Gm-Message-State: AOJu0YxS1xoFZGN+awMoCKlGgTGoUMhZJy05pp2TiEaCnpoWi8ad7yfu
	dxheyCi09VTlLFmzTxocpleoLJ+W2F2X+sMyyBSjuozR7+mtzhIGYCUiM2S0/bb6EZkVcwXvy1K
	MsXLgsjLGOVMoa1urdkXqe7hSHJ0J6XO8mUlD5Z68
X-Gm-Gg: ATEYQzzbO6pl8HbEGbQq62MrKLCCJLtDsAD8NxzehLupCqArRUGlRKeWojLU+lajdz+
	GYI2cA4FoAtK/eADuYCgu1UpM1KL6JrZY6erFYLheJOi1jaaIN5x7/OdIxWbGc5P14zBW2bz/rV
	t6BX5z1+rErs6IIz+8T7zinOZUISnCusYls3cAoRoza4LbF7+G96TTyLU9XecPAbsaziGHa1h30
	KEdbE7pXURoGXOBH3lZ5cXH6Yf9zvswVrpkl0vj/UuN9AAK+QOOgDdVvdTqJlgowNFUqKzQr6/5
	aBMFPZ/v
X-Received: by 2002:a17:902:e54d:b0:2ad:ab68:f2c3 with SMTP id
 d9443c01a7336-2ae81e624cemr2487815ad.13.1772816007246; Fri, 06 Mar 2026
 08:53:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306071002.2526085-1-tmricht@linux.ibm.com> <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
In-Reply-To: <aar4GKP1c66egZnn@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Mar 2026 08:53:15 -0800
X-Gm-Features: AaiRm52ymk7n_TnJgTnMzHWevukVygoazKQGzkWbtsoNC-MRSTc2_F6Kq8bl054
Message-ID: <CAP-5=fXs0UrMVhwU-_=iunCYa_ye18FHj0W1V8sE5T9nOkeZWg@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix test case 120 and 121 for s390
To: Jan Polensky <japo@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org, acme@kernel.org, 
	namhyung@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	sumanthk@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 7:52=E2=80=AFAM Jan Polensky <japo@linux.ibm.com> wr=
ote:
>
> On Fri, Mar 06, 2026 at 08:10:02AM +0100, Thomas Richter wrote:
> > Perf tests
> > 120: 'perf data convert --to-ctf' command test
> > 121: 'perf data convert --to-json' command test
> > fail on s390. It is caused by selecting the default event cycles
> > which does not exist on s390 z/VM. Use software event cpu-clock
> > and specify it explicitly on the command line.
> >
> > Output before:
> > =E2=9D=AF perf test 120 121
> > 120: 'perf data convert --to-ctf' command test       : FAILED!
> > 121: 'perf data convert --to-json' command test      : FAILED!
> >
> > Output after:
> > =E2=9D=AF perf test 120 121
> > 120: 'perf data convert --to-ctf' command test       : Ok
> > 121: 'perf data convert --to-json' command test      : Ok
> >
> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> [snip]
> Thanks for providing this, Thomas!
> Tested-by: Jan Polensky <japo@linux.ibm.com>
> Reviewed-by: Jan Polensky <japo@linux.ibm.com>

Should we not fallback for the cycles as a default event?
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-record.c#n1374
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/evsel.c#n3792

Thanks,
Ian
