Received: from mail-ej2-f38.google.com (mail-ej2-f38.google.com [74.125.228.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8A4CE677
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499090; cv=pass; b=RlYWqDzrxaY57VsGISfWdM7gfifHMptgAWJXY3XJLb2lxiGzqAulrJd3h/oe3qqmpDLzSD4+H+4/FN6eLdhRzUwR7iLY6NiW4zmKyZ0vwYujQqtd3yqwUR3EsRE8+RL1wub46yjnbA2eJZhhjVMZt2E0QNgYZZ6UD1B6ibbLakU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499090; c=relaxed/simple;
	bh=CG49oeYgRKGkXZIpez+UfckpNF7tbwFkBXsCCjJfd80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gRP0ccZdb45dovSwQVNJGscjZWa5VeRDenXcIQiKfSIKKAFdclmMHHqPlZuHwNwqh4TH+QfeQp3AY/s/k7u4K0yqxSHty37NPJTOujRVONe08kwhwGVHVmET7BH39VCCtKeeo6Fd6sNSlmH608rCl5AIUzTC4x9hK71RS+02qwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com; spf=fail smtp.mailfrom=uber.com; dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b=GHNSb7ls; arc=pass smtp.client-ip=74.125.228.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uber.com header.i=@uber.com header.b="GHNSb7ls"
Received: by mail-ej2-f38.google.com with SMTP id a640c23a62f3a-c254f560398so29234966b.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789499087; cv=none;
        d=google.com; s=arc-20260327;
        b=cYVd0tL++37HlB7sZOUJOZK2A/zIaVyqNu030HZojqDTjnAw4u/uaEaOULIaL39ban
         xMJKyh9Y8RudDk2Q5x2XO6eidgxB0nYZ5q4ahS6s+kg8eIkWQuhHg2192KR9uJMtaNCG
         3CT2r/EH4wMPjGs87pAtpQSx9GHzgTFP/avuzcG0IKdhIjW3qkrlxp6H8BXxeYaoAHCf
         Bezeyg9n0So9AWFQSE3TutK7+tyErThvRErI6lT5TaTVbcQpSaPwNWxGQltkihI6ey9n
         R0atW71MYyMqaGAKvTC3aBmri6Ev9nLzLkjaPf42TWAUag/gdMjvc876zXF90VIP3VdK
         OGTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CG49oeYgRKGkXZIpez+UfckpNF7tbwFkBXsCCjJfd80=;
        fh=0zVHGC//SC94CWFKHtFt4lnskmkXkJNNy7lE0FDd3Ck=;
        b=HHyHbUYckNB3YP8iuHnr62GAgRoOfl+al47m5EtcrNAjMANqRTF2CqBOkgvT4TnqAX
         3Cy1ORKML0EeV+/WzT5FeIYrobmDbL/pAiSQBPGL+cQEbfaHibUOMbc8FaB+3RuX3L60
         Tj6RwU50W72e3CUKor+kV5ewGIN914kVE7l1Tk6wEZdE8+9gZGBbhUwzBqryRl1J0tmQ
         T2rF1GBPnmp4w2tQ43vLzItV4QKODNNdBv4xKCWWP96QXgrOU0fex/7ExW/cV4QmMX8W
         NtaSVrloqXOMelQJOdsYPW7yiCzesOHLZCSXILxHcsUyiw2JqausPjQQO3cZqcjqUq/C
         dTGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1789499087; x=1790103887; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CG49oeYgRKGkXZIpez+UfckpNF7tbwFkBXsCCjJfd80=;
        b=GHNSb7lsScEjPE27NgnKNaZWhKAA3vaYlWs2Ouay13k8BhrOL34qyojZwsGao/i+Io
         O1NKqX80PwsEMTT9R20Hej+C3V9Is3wm6qXgL7bZc+VsZH7cqGqVFjYNlPMVIOiMlu1t
         y/JlDCAw/zKS36utXSwGzc23Q8XtEZBMMPShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789499087; x=1790103887;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CG49oeYgRKGkXZIpez+UfckpNF7tbwFkBXsCCjJfd80=;
        b=BITDSr+Qs3tI5wwU6oepjo2pzzT+J3P6c1rfrrsya4OPriEwmTKsAd+/iwAOcxBw7/
         Ijf88uIXKHnVqKR74jtYEL+t7KP5KCdMBNIdS6dKmF77OiyNhn1Txx+Esybbr6x7FrZG
         RsEzy2ElIfuBGVzaVFwgjTlxbnxdtC9aLNgLcb9QeOAYhRVVzKn3axIkD8xCXbzDx323
         mcgj7AoMFtEwzg+VqwycdzLy5lFZTfHYN4zmjJE04wGqxV0ao1pqm1fmN6cYBwQH1G4e
         LowSyb8lxvnmJFp7eXwwcdv1S2/89I/ijKFjrnWoNCkRgvusAv5mG8zJ3blDtKxQ0Qb6
         8cTg==
X-Gm-Message-State: AFuF++kX0/X4G4o500Gjf9DprZ+paP0C/+wlvDGUlNYwDoniTMgHgCWS
	OMlUXdlqjDlb1/4+r5g8tNc584ohdO6I6ck3HMQoVSvqfz+pnpDuvyUyLD9iN9BRsXFq7DbF2b4
	zicbgMLpTVjpwTs+Pag8aMhZKmJahGtinfKBMNVuANA==
X-Gm-Gg: AYBFou3yfgdY3PuhJGoREX8y0sYHia9p/P9jP+OvbBZo9vE/WEolZXT1SGEq2yyAewZ
	D7dJq0+Y8LweXtglnlxv25TreXu4fYRhYNSeyEvK0qakKmsWHOMY+2Rgi5CKH5lNXIP+EFBVS8t
	bUCVU5s/WbohHEjSMpNbifkaotWrVKQo4ENOK2GIIS2dcZEZVZV6VVWUb/6w4pNJkdbLApZfc4F
	q5HLaOl/RkwOyunnVyCHKOw3VSGEY5JRI0/or2mr8y8cqGGocGoFBwPFEpN7JphfZoPw2f0IL88
	rnM+FJbIOsBdN/fOJwrfmLxnlskQZaSm23E3kumolTzZWsjjjGm6mZyy2RfI1bemkRTVQkgglHa
	zj2MnXevwCeU=
X-Received: by 2002:a17:907:1ca4:b0:c29:4204:8dbf with SMTP id
 a640c23a62f3a-c29d7733739mr190073166b.7.1789499086483; Tue, 15 Sep 2026
 12:04:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
 <20260915-perf-symbol-memory-send-v1-1-1d3360e21f07@uber.com> <20260915185318.0573C1F00893@smtp.kernel.org>
In-Reply-To: <20260915185318.0573C1F00893@smtp.kernel.org>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Tue, 15 Sep 2026 12:04:27 -0700
X-Gm-Features: AcwNN1XVfMPCTdeeQv6DV6pTbf4aLmDnQHyCC4-DGkKjtADM5TgV5RXmKioy6qQ
Message-ID: <CA+w=M=Rpvn9QpbvC4UWex91wNZ39BNmjt2-PaACNS1Rsai3uGg@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf symbols: Fix broken ELF_C_READ_MMAP fallback guard
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Could we restore a proper feature detection mechanism here rather than
> relying on an unconditional definition?

Thanks, this is a valid concern. I=E2=80=99ll restore the compile-time
feature-libelf-mmap probe removed by 22dd1ac91a77 and use it to select
between ELF_C_READ_MMAP and ELF_C_READ in v2.
