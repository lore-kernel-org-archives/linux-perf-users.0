Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40E3E1D05
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 13:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782482198; cv=pass; b=WhelqnhjzCy/MVx2a3O1bWjxQyTnbpefovoNAD28qdlFD3+MqHB8r+8YKcdxDT4L+N3Uh39h/gtcYfG3syr8B5nJ1DIh83vLP+3f2VS3lshEJdMynd9b1SqTd9gSX2eS1Gyh0iVxDy1V8rJR85G5J4ad/GL+G6+UWqBT0PzIK+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782482198; c=relaxed/simple;
	bh=YVDL1aGMn8IULAzLPaQ63t5D6FVvaCLO75OWrWADPZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUFM9eVb0MRFVIuL2n+V2vzrBPreZWSNRD35pDZiZ2VMZD56uo3pOdGjA6UErzVIww1V+EWXqN2/BTx8bPdL6r0oaV2wectj1UF/qg/iRU1jHrX9cTKT9v4MoGgV2wdr4EDOfCwSdbDFw0r+Vfkg5bcxr8ZyDw9AapgFChqG24Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn3KVw+R; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn3KVw+R"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8ce0f17a69cso8398146d6.0
        for <linux-perf-users@vger.kernel.org>; Fri, 26 Jun 2026 06:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782482196; cv=none;
        d=google.com; s=arc-20260327;
        b=SD/oWkuTfP28Oryedqw2ipWJ9oqpZQ7AQkBtNS91SzgckezKmkEoMgncRseESSzN3b
         B4iwBVBxi33E1qc91DMbM8BeApMICFudiC/6Fp9wma5oH0GIV3ZcTml5W8vkBfb6ute1
         aG7jkpK4hq0ecr46Y5UbPrx+s2EDtPweedPk+Rm+E1gblD8MCncg7EhdN2Pwy22aGKTk
         uKf3Z5yXYaf57xBVrl11DKlCjKvFawDDrmvbaW8zoBvK8PSAxtRZC6aWL9EbXdJX+3Io
         Fb5jL5N6eDr4Eq5aAzppTIChsa7qjEyOdx0MzXoceUkJFb+Rj3yTK3+eQpKtvI0ekEZ9
         paMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j8UgPLpU59EN9jrvEy4338bhTXSBs+KvINqBsOxg3n8=;
        fh=NHGhhXMekIQd9nGASjjXGi16icZmme/GpoQnD72Lr5M=;
        b=j2jLes5Y2V3/Hs2a+sGRE4z/TZVb0VW9RXjTYbykkCBRlS/7CFiwoa1x+BcsssaZKu
         uRSDlhwjvkDc/+vI1hqaxDwCKYMgRPxCfDLXPBzGibSwy8pAT8ml5n2mbODV4J0vt2el
         BOwyYwfnyD+NlLe0eErROc02dgEXXC39UjzAnYErHCd5L7FknScDe5liw/deAzRr6Naf
         trD2RFg5GNMBDcRPbEcWaT7FnGrYT/Qe8AOO5ZwLVwpI3JJS2c+5P4o4VTXHToOMnzjc
         tDbHFEXNgl8Yc8fW+b2VMVEJYtnm8VdNINwgRjuUwgmMClmKZuK2xEV32eT5h3D3+rz0
         AS+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782482196; x=1783086996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8UgPLpU59EN9jrvEy4338bhTXSBs+KvINqBsOxg3n8=;
        b=cn3KVw+RWN5wCPce2bjgeAqV16Jq/VOSh4CZnAZIV9h2Qiwo7xv8iahtf/iXNKqvQe
         4xdPpcSFJ7t5hbShqwxySoYn5raAZTF9eFS07k6N96Qz5easb/xc7TiSJkl0We4qecs8
         P1+5hWNpeUYPTM4d23pb4HOuavBmKQqKQIhK7l+aTizKkTajnzxL0j6qrCfIKPY4RS8A
         +gma/xq0E5dcr0tB+2QLk42oozQyvI73Diak6kP/xjutAFuapGtQ56lLD2uH2jgUoubQ
         5xod44SER6yJFjL5aG8NXM1oUkp7/NXH5/HefRjMFw2shQpYBQonfn9QuC9c0o+uXxDK
         4wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782482196; x=1783086996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j8UgPLpU59EN9jrvEy4338bhTXSBs+KvINqBsOxg3n8=;
        b=XoJdYq6H/aiVpRYBLBoTjlXwtZPx4TkQQQPyHAbgttw51G4xzUxp5aIVDbJsiujvEU
         y721uBDH5DhWhHQDQiXRyqQuVIidHrrNrTCbu6Nk708s+sueDGTSpmmJzvmD6i/AhnpA
         6uEJ33Uq4FrADwQVrRR0UIjVBNMgFozMNspEpvs6+p/ZSI+yGD1LmYPMxre5GnXfuF5C
         f/eoVZjT5xYkp9jSioc8wakuR3R4YZdO35bp/HE3XiXImQGHS1uft1G6mGOgNakmgVfs
         BftyaO0+EQ6yfxJ/WmphG7mKYuZi0SSSH9YcKnMDndAssjaJvhkM1wkOR1L2eAlRofVE
         ZD4g==
X-Forwarded-Encrypted: i=1; AHgh+Rp0knzhSz7O2unDgxSf1p9jepaNPq0qWDSfAqWt9pBzbOn8h0m4CQgLRnPfUePY0oRGdrUy4gGyERF5usrb2hPJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lWHubOTXxgtC4l/66p88qCC+3Ox0QbpQ/Etf3Qf1LpU5k9jw
	Vd1N2lEEeLFiO7nyt+sxFmY9etiQSVcKpk22fbASLl8+BN8I96tb50jZ/b4fod/7FZ+E8mT6Uwp
	9fml5cBT+nslId3LCmcnSN/Ce9L4IyA4=
X-Gm-Gg: AfdE7cl8iMc69U2zzsu1w/XLrc+QMHp1b4KEiEI50D2L1WNZ2++JB0SVldsAwi8Faph
	7uJI2GeYP4y0kOdbwCkqu5aY7qLoYAM3hpTuoh1ANMWqVMTVDRq7EXwALv0exSrwXzRrRYTp/w0
	tGSm4fqer3pxNxe8C/BzYvkiDDa2GQhC86Ky50DGxqAtubJIIBWvcTU/Dqs9b9P9Ze5oWlKvafw
	wMqecy1qAQSmUz4tYUd0TfMdX/cDFxpe9VnMTQBx2clUpiKPMPrgnGeYNtSAkwUx+YElIjvDvtx
	OzAo8FFmZSxxAo5Sal4zL+W5wKDaY/q2+l4=
X-Received: by 2002:a05:6214:300b:b0:8aa:a025:78e3 with SMTP id
 6a1803df08f44-8e6d5fa1841mr110765616d6.6.1782482195752; Fri, 26 Jun 2026
 06:56:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC5umyi0v8Z3Frtr4yL_LRZu9O7wWF1HZfVbutagORde_i-7XQ@mail.gmail.com>
 <20260623134951.67000-1-sj@kernel.org>
In-Reply-To: <20260623134951.67000-1-sj@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Fri, 26 Jun 2026 22:56:24 +0900
X-Gm-Features: AVVi8Cd52BvgGNRDlWuqiJtllEEyQt-RK1HSoMYDsqisgeQtuaev5JOT6AjbT5w
Message-ID: <CAC5umyj0qTqR0HpHux6+G6bvGCQqtM8CVVXSZSCt66OtJU7+AA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] damo: support perf event configuration
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	ravis.opensrc@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B46=E6=9C=8823=E6=97=A5(=E7=81=AB) 22:50 SeongJae Park <sj@kerne=
l.org>:
>
> On Tue, 23 Jun 2026 22:29:42 +0900 Akinobu Mita <akinobu.mita@gmail.com> =
wrote:
>
> > 2026=E5=B9=B46=E6=9C=8823=E6=97=A5(=E7=81=AB) 0:24 SeongJae Park <sj@ke=
rnel.org>:
> > >
> > > Hello Akinobu,
> > >
> > > On Mon, 22 Jun 2026 22:49:31 +0900 Akinobu Mita <akinobu.mita@gmail.c=
om> wrote:
> > >
> > > > This patch set aims to make it easier to specify the perf event set=
tings
> > > > proposed for DAMON by Ravi's hardware-sampled access reports patch =
set [1]
> > > > from the damo tool.
> > >
> > > Seems this patch is built on top of the per-CPU/thread/read/write mon=
itoring
> > > patch series [1].  We made a plan [2] to use another user interface, =
though.
> > > The plan is, making the interface ready for page table accessed bits =
based
> > > monitoring by LPC'26 (milestone 1), and implementing the perf event b=
ased
> > > monitoring on top of it, by LSFMMBPF'27 (milestone 2).
> > >
> > > So the eventual damo part change for supporting perf event based moni=
toring
> > > will be quite different from this series.  I guess you are sharing th=
is series
> > > not because you aiming to merge it as is right now, but just for shar=
ing the
> > > code with other stakeholders like Ravis, not me?  If I'm not wrong, I=
 will skip
> > > this series for now, to focus on the milestone 1.
> >
> > Since I will align with the final user interface later, please focus on
> > the optimal interface for Milestone 1 without worrying about that.
>
> Thank you, Akinobu.
>
> >
> > > Please let me know if you want more of my feedback.
> >
> > However, even if the interface ends up being completely different from =
the
> > current one, I believe that enabling configuration via `damo` using
> > symbolic event names like this would still require calling the perf
> > python interface (`import perf`) from damo and modifying the `perf` too=
l
> > itself; could you please check if that approach is acceptable?
>
> I'm bit concerned at having such dependencies.  I'd prefer making DAMON s=
ysfs
> interface uses a symbolic names and just use it from damo if possible.  I=
f that
> is not possible, could you share more details about why such changes are
> required?  I'm still lazily delaying studying about perf events, so pleas=
e bear
> in mind with me.

Theoretically, it might be possible to initialize `perf_event_attr` within
the kernel based on the symbolic names of specified PMU events.
However, doing so would require implementing logic to read
`/sys/bus/event_source/devices/<pmu>/format/*`, as well as duplicating
functionality within the kernel that is currently provided by the `perf`
user-space tools.

However, if we limit processing to only the minimal format, such as
`pmu/config=3DM,config1=3DN,config3=3DK/`, described in the explanation of =
the
`-e` option in `tools/perf/Documentation/perf-record.txt`, it may be
possible to minimize duplication.

> >
> > Thank you for your continued excellent work on improving DAMON.
>
> Thank you for your grateful contributions, too!
>
>
> Thanks,
> SJ
>
> [...]
