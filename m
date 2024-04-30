Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C310799
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 03:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714448460; cv=none; b=UvwDR/Ts7SIp91kRaxiruv0EKh85iqir9ItWGP+8EjyJu+ZiMwGFJUqR2emv0b+gfWMw4ZftAf2WzFB3iQacLonq+MRXi0tbtDnnJ0UPPhTtYCv329CpYSvxV6vXbSgn2nwdgD5l94JOYj1phIg7F0WAgg4cfplSzezqm025phE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714448460; c=relaxed/simple;
	bh=Qp44ONuj8/RC8FVxYOU6sZS4U2Am8Z7QeUTc/MM1oxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hWKgy27wg5huyYqPgaY4M+Yy6N/4JRZTHsKfmsEhbN9zMC87LnUckddzYU/tZ6H109auxQO3Upm5Cj7PqBWDhBIHeW2mpwxrdZOn3nQc3m7W0lJqPaAZjNL+WIakoj4WWiVr5xcrT8WjNWUoXHMOkBqgTvO4sD4X+MGtYcGvqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EQ6k+sJb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQ6k+sJb"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e8fcb0b860so63765ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Apr 2024 20:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714448458; x=1715053258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qp44ONuj8/RC8FVxYOU6sZS4U2Am8Z7QeUTc/MM1oxo=;
        b=EQ6k+sJbfTUipiOvv+LTveIdLcvy5xhVqSyJnZqFU+uKJkc/uBDzACKobC56M+g9u/
         pm1a95ljsbbAK4sphz2pPkEhwAuCB5R6RmVJzPmUuRCRYhglRAZSHncF5GrqaWAc3Cxn
         Bm4kJuwK89mUJ++5+mr5++Fb8rlTUgo18jNkc+gKgw+9OiOZkxFHRMe35A3flcRHfurM
         s+TGMrmQfDFqvH5j4Tq9hG2Zt6vTjWpSoc/xQ+PNGe673M+egtLaNLwXcot3iH1GjQt5
         aBRahfJhI3oZNdmwbn8mdIOmyzvtcXm90uV6lLGgFrDRHeu9RI2XTkrz5K0nv4NErsoJ
         6WWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714448458; x=1715053258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qp44ONuj8/RC8FVxYOU6sZS4U2Am8Z7QeUTc/MM1oxo=;
        b=rLMFjF/xhiuq0UfKdZzh6UpLqmniDE0PTpzhvgYrd07En81EGus3qoVpdqVAnrq4vG
         MWLOfz1IjGyv4PgWIYfCI+c0h8MKJzvVbTdxJjiJ/icKFhFfsK2P732ZsJo3k7LGrTzy
         8GrKxlJt7ToF/H4b/Xj5EsFFBSatbAc85D7FNjyMuph5AvkVPxtZl33FsZ8QdfIkDCZ2
         u6rKZrsO99wQcTFjSRiN3F5yQBTedJmatfXmwfQ6+YYBRVhWjFXc/QKMMHHkewOZyOKE
         CJ44XsNRU45JFfonJst41ltai+eXr0r3vrV0E7ZAFwTQzJBZ8An+lkumzZxP33sjxbPG
         SSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVngUY4Fc0O0TGUNMoNjwSDJU5MkneVl6Mo/DCKqlE6p3eqOwuHEswiP8uESReBoy/VUSJldrcYZmtWuYrKT4qa1paeC36BL4vPIvugNgoL8w==
X-Gm-Message-State: AOJu0YxtxxMp+LyxcHdfbPFhFv8vWxbShiHRDEzwo81ugQZVqqEF/0cq
	o0IhdR1MKmG1iZktxZwJnXVf7+Q+ZrlWvyG06u8OooNxigtWvrhMJGRB9+UA/yY2X8+zdKDZxQ4
	jLdwvMlxfMOzerhon80IFOlBzSVg/1vFBPekG
X-Google-Smtp-Source: AGHT+IFOKp6IbuJXMVwCwvy9B4FMcOUU7Ohar+bPXibgNEKIrHt2Xjq6lZ5uTOSGPc/ULMfM/M9MDhn/YulZPxH0XMU=
X-Received: by 2002:a17:902:c404:b0:1e0:c571:d652 with SMTP id
 k4-20020a170902c40400b001e0c571d652mr90602plk.1.1714448457985; Mon, 29 Apr
 2024 20:40:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <80f723d230744bc299044cfd4f8c4d92@shmbx06.spreadtrum.com> <20240429214321.GB125@debian-dev>
In-Reply-To: <20240429214321.GB125@debian-dev>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Apr 2024 20:40:46 -0700
Message-ID: <CAP-5=fUdVHu6a8TLi_HYOZv3Ur_Sr4nvx92rkSaxxKJummPzKw@mail.gmail.com>
Subject: Re: Question about using the perf c2c in UMA system
To: Leo Yan <leo.yan@linux.dev>
Cc: "?????? (Baisheng Gao)" <baisheng.gao@unisoc.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"???? (Hao_hao Wang)" <Hao_hao.Wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 2:43=E2=80=AFPM Leo Yan <leo.yan@linux.dev> wrote:
>
> Hi Baisheng,
>
> On Mon, Apr 08, 2024 at 10:52:59AM +0000, ?????? (Baisheng Gao) wrote:
> > Hi linux-perf-users,
> >
> > My perf tool version is 6.6, and I compiled it to run on an Android sys=
tem.
> > The problem is:
> >
> > # ./perf c2c report
> > Failed setup nodes
> >
> > According to the articles on the Internet, it seems that the perf c2c i=
s only supported
> > in NUMA system. However, the cache false sharing does not exist only in=
 NUMA, and
> > the UMA system has also the problem. So I wonder how to support perf c2=
c in UMA.
>
> The log above is related with parsing NUMA nodes, but this doesn't
> mean 'perf c2c' must run on NUMA system. My understanding is both
> x86_64 (memory event) and Arm64 (SPE) support 'perf c2c' not only on
> NUMA.

The lack of SPE on most ARM hardware really is a pain. Can we add a
better error message to make it clearer to users that they need a
neoverse CPU? :-)

Thanks,
Ian

> Thanks,
> Leo
>
