Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5AD341062
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779127148; cv=pass; b=uPDTywraLPhdsBhPVLtihJxa6IE8gh7cwOzoSrmOWK370XlfYpoEBXLGKjcI84gG4omo5nrxgTfftwKOjdSLlY80R5eUN7jD4cPTjZGBYw1mfAG1vG7t/rFrA6g4qC+AwA80Xv2McoAGLvjWd+apCIT8NkK+ZGjqv2pRD2u6ruw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779127148; c=relaxed/simple;
	bh=BzdhjOleflNcSnMJTzY3NHEBzuU8Vcjeo0X51qRJ+S4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDWQrjo6LRIGi9hHBoMsdMwNjqSbnhKf2VsOneBJf9w5wVGjH7bqTEstdsd681iDXXq9gv88LoDkxlBB2TZSEjSGlVncoY+DTUtSvkNVbQllb2hxmdP6bx14KA7V76IvL2Y98yeujD7aN6EfQ1QkwYhJKlqXUwL/zihbKKPNC/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L4Limet0; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L4Limet0"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-132d1b2519eso7168075c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 10:59:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779127146; cv=none;
        d=google.com; s=arc-20240605;
        b=YIV/PYOfKfT86DquRLnMIBtFU4dMqFoR9E64Gi89A3yGpMJEGnmU3bI+a2HA8vSb0+
         CCqLsb9oCc26Xev1foE2+Br//TxoF261E62siHCea5u77FJgU7df+hsJaji3YWAWGEm3
         yzpvy8U8gMmygfTdnIBaZEOtrHaBC2PRGDuywrrpwO6A39UZV/7D1xHmDojJCN6Zflii
         YqgXv3dp1B3AUou3hz8ziajAN2toNBLbBQwWYOWMzkLD7RCRzxsbpahHuXvDFud6yh/k
         Lo6aBbeoif6xxbOvemUVxLApI3bU9X6+z2wUauyaCrxNxWcqeFFJRAobwAfYjedenQLE
         TW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vZiU3URHtdplpUkGm6D2sr/NN6zozFwOe97brJy2u1Y=;
        fh=TQc2u1jERQYWflpxUtRf6m4TQA5e52qDghyCiHAlCb4=;
        b=SqMPD/UeHYrwVn1f0qTPN/Mrci8z4t/7GDLfPK5ddOEO/n5FuAVY7Rgqlq1dbkZOnb
         auTE/QeBXBy43AVJDZBZ5AvStXVqEpFfaUD2uoEGCiI0LZM0avdssKpGuWyZPd2fWRW0
         nJ1jAXO8IqOBO6lstiaJnklDDL3xPmtDNsaLI3YLR4r4CeYizy54vBNNzNhrqQcqZIfH
         tUZAK/rKDD8Ses1mdzH7jVNQoNAt6ZGnChVhC+tEpdUK9ZlHe6XqDar78QtdZtXM8DcG
         E03JYQJ1t7i8N00JjF5AuVD3jyE5uUDyljMhmM0d5o112Z2p65RwVc7OeMuUQvUP6g+w
         hQ3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779127146; x=1779731946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZiU3URHtdplpUkGm6D2sr/NN6zozFwOe97brJy2u1Y=;
        b=L4Limet02Iew5CgeAUJcmCZx1D84iBraeJQekTA2+uBANf7/I79y3QGYa048doUQem
         4d4g8OFCi7N/yAfA5zDqcrTXRbjI5MEBXY62TC6Ae9GKRi25k7qdhu3kxh2PcloPAMme
         8M2Ler3xLIjgZkLojRpP1miCq/Gkv4nKyr5ARSLFzRr0p/dC4qycLeWohMTeydphIvw4
         J0COkDYWcOQSMSm1/8ZbbnEdSZt92uUclAGtgoqsUC8g+/Yv+gnUl+ADElrq+WlXrsFc
         vSZEDwbJVfH5uWrs8fa59g6cjW5zMy6Ly1bzbRW1+OTrml3WBJiaoZqip1WMFSTK5/T1
         KUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779127146; x=1779731946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vZiU3URHtdplpUkGm6D2sr/NN6zozFwOe97brJy2u1Y=;
        b=Qkfioyu8PNwXkYHP1qq8LTyYmHgOCt5IskAeamDfi3LqggFZiR5M+oot4D4Teod8vg
         cdXjkE7hWd7s9b3z6tQes3206Zb4f6359Uxkebti1gExc+NwuFNxaHEqUFPXCejf6xaK
         ElafHWoaX74gB8ac3dcch8JgArrLR6JD3RMV/IdwM3kHBrIgXMtp4sR8zTb/pf4Qvwbx
         hh2LD5Eaxj4/08qv/mg0k5vUYXm0lKVuacnVPLi0iP7huJCb1vqWcxGF7ngW5+OOucGM
         WUnWW1uyi/iNCv/Sacp8Uulnq++4XiLj1RtIO6l0ywEjTHjfCGAw4u9ZGDIHIXJMr5XQ
         qGQg==
X-Forwarded-Encrypted: i=1; AFNElJ/c3cT8NGNSc8hr2H/TksmnhS/uDn9MtNBd9RC52i5Vm0kxgu6BZthFb6FPtDFsqrb14n2LFgDBdqVENtrim3zk@vger.kernel.org
X-Gm-Message-State: AOJu0YxseUvRWDNA27SFjx714uzxz5f8Ek9fltP7Yf5OgPxcweD188sk
	OTL6dLZJbdujN9GAxcgR1QPH257JlziAq1gBHJTs86wSPprZ/WXA9A2sVVQEr5dkhRYV4Mk/ROu
	oVexFLQVL+ckUblkA0Pynbmj8BEzZi5aRQroNBiw+
X-Gm-Gg: Acq92OFb7u9s1DskLUZJynPHlzGlCSjVSh9EmZ3qNsN8XHPe6MxutIKmDL0E0bX6QgF
	FN9P8tOeqLg479S/MX179Ba15pilgQTuyHv7AuOTmEyw9XE3cc9HXPLpwSYsPd2l5WpER5AH8WI
	16XEZy4OpS1G70jEk8dAEQRZx8OPi70dVmVENi6jUo2d0VrkQRh81FkRFfAV8rPepALtN5IRGih
	fwnCJzQwi/OSkkl1PeQ89oVDg01peMnOi3rgTNUn+1ibb8KZOYD23/GQ8YugdwNlD9JSqyjSoyw
	Pbh6j9tTWPeeU6DLcuaejEix36coFRmYxkymtjMiY1NMIbkZnQqbV8L+0Lc=
X-Received: by 2002:a05:7022:699b:b0:132:d182:3dd6 with SMTP id
 a92af1059eb24-13504515a28mr7763476c88.16.1779127145579; Mon, 18 May 2026
 10:59:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517114026.6817-1-vasant.hegde@amd.com> <20260517121248.0E501C2BCB0@smtp.kernel.org>
In-Reply-To: <20260517121248.0E501C2BCB0@smtp.kernel.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Mon, 18 May 2026 10:58:54 -0700
X-Gm-Features: AVHnY4J0e7nff7V4CwWJo5iWI6qRb5Hh7pWeyl_OeHVpiPpiXw5-pUQ08QZ7RqI
Message-ID: <CAJpZYjUSvQ+iFdo+21-2B5gTs-T8GJ8yxOXk53bLgAuoGNmniA@mail.gmail.com>
Subject: Re: [PATCH] x86/events/amd/iommu: Fix cpumask of IOMMU events
To: sashiko-reviews@lists.linux.dev
Cc: Vasant Hegde <vasant.hegde@amd.com>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Chun-Tse Shao <ctshao@google.com>

Thanks,
CT


On Sun, May 17, 2026 at 5:12=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] PMU initialization fails for IOMMUs located on NUMA nodes withou=
t online CPUs.
> --
>
> commit ef1363d0a37870d7cf1f1095cd3ebf42cc5a8bdc
> Author: Vasant Hegde <vasant.hegde@amd.com>
>
> x86/events/amd/iommu: Fix cpumask of IOMMU events
>
> This commit changes the IOMMU PMU cpumask from a single global mask to a
> per-IOMMU mask based on the NUMA node of the IOMMU, allowing per-socket
> performance counter collection.
>
> > diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
> > --- a/arch/x86/events/amd/iommu.c
> > +++ b/arch/x86/events/amd/iommu.c
> [ ... ]
> > @@ -440,6 +445,20 @@ static __init int init_one_iommu(unsigned int idx)
> >               return -EINVAL;
> >       }
> >
> > +     dev =3D amd_iommu_idx_to_dev(idx);
> > +     node =3D dev ? dev_to_node(dev) : NUMA_NO_NODE;
> > +     if (node !=3D NUMA_NO_NODE)
> > +             cpu =3D cpumask_any_and(cpumask_of_node(node), cpu_online=
_mask);
>
> If the IOMMU resides on a CPU-less NUMA node (like a PCIe expansion switc=
h
> or a memory-only CXL node), or if all CPUs on that node are currently
> offline, will cpumask_any_and() return a value greater than or equal to
> nr_cpu_ids?
>
> > +     else
> > +             cpu =3D cpumask_any(cpu_online_mask);
> > +
> > +     if (cpu >=3D nr_cpu_ids) {
> > +             pr_warn("Failed to find online CPU for IOMMU %d.\n", idx)=
;
> > +             kfree(perf_iommu);
> > +             return -ENODEV;
> > +     }
>
> Could this cause PMU initialization to fail for IOMMUs on CPU-less nodes?
>
> Since AMD IOMMU performance counters are accessed via MMIO space, they ca=
n
> be driven by any CPU in the system. Would it be better to fall back to
> cpumask_any(cpu_online_mask) instead of returning -ENODEV when a local CP=
U
> is not available?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517114026.68=
17-1-vasant.hegde@amd.com?part=3D1
>
