Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72CB3C0635
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 22:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779317049; cv=pass; b=fu3d82M/nA2VGoisQeVZYNuSbws9T9yOf/fvqNGaliM27RJ47BBckBt+erV99K9bzS+G0oIRXnFn1eCBYUHU7creROI4E4DGoT9IRR0vzkiNIw0jzAkBf5oIovrN4l0rUmTZVlpMf2Sqv1eIowmNQcdO5rHXJKGSHIJxsaNpKJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779317049; c=relaxed/simple;
	bh=aK2flb8TkEpF1bv8LHeBepy6NB9Xgn4WwtqvfFm6Yj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fofBb0xhEIW3OrUK+CpsvT7I+ozn/nHcGKjnEXM8fYJD+bd2PC6IZgvIAcHSDwIiXms89Uck3sHOSLSqi2g93n6sYKv1FeVrkBayeACOzoAqqtfMc3HSkH8r86zysE1HT/luJzeIC3x7wq7qSi8w+E/w6Q/aB4VL9Oj4T1tHqOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FV9BxDsJ; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FV9BxDsJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b46da8c48eso505ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 15:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779317045; cv=none;
        d=google.com; s=arc-20240605;
        b=gOdZaW0mnWkZRG+Do/yvxDLEBChwhCAxy1iPxa++TOw6nyISTkOTRk5Tp5vH2f/axG
         EFvKqboBlWkHNXhmsyVTx2TiOR/ou5npSjclTs8SuIKwTZy2qmFVPuZJC+Y4UE9tjcbb
         ZJOcCFU/sx8mKNLrdH0A+/XvVyBmY22q9huu/3Fq38v78e8szo0zTq3Ito5zA6f7mBr7
         c+B6sA6V7sY+m88wf0bmlhdEsRZLB9Nl2Pb28QGnWIUoOdeNwWbUTRfZ2ZI/qJbMODDT
         IP9m8AIy3ELyUBSv7DO2MIouy1IaI5eCwM15oHxIylt5Ac6Y4mvaHplzKRbOxFdjznG1
         TbOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aK2flb8TkEpF1bv8LHeBepy6NB9Xgn4WwtqvfFm6Yj0=;
        fh=hAR/pIlDuqcodEmMLZu6uiMbvwjPzBbwv+yY1Syb3sc=;
        b=D+j2RQ/Bk4yFDNswIq/Zluq8QFGXJYVtt8GkB4xOQKka+lbpIabEdauQBgCNnMeRxt
         PVbthFWFP6vnnEBteZeMy8mNpj5bXrF35/wYnEackLu5+4X0VapCG8wOXkJ9CxuIVT/Z
         /WbpJiNFmdjW7YDX8AM9c6NVFG9Z9aIwBrZe+cuO+H/UlEltLw0AdJQ9engbSKWaIYWp
         x+4p9OtG72PHowjU00dpDaKjxF8Vax6Ab9mlxfCyTlqihBGBgNWfeZY2WLR6Rw6hQ4pO
         oXzrTWAV52pWJ/6Zw0O7ABkXDxfxqN64zAsD5AGK92dfVDO+F3aABsh9zg7ewRGdqvZK
         tCsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779317045; x=1779921845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK2flb8TkEpF1bv8LHeBepy6NB9Xgn4WwtqvfFm6Yj0=;
        b=FV9BxDsJqmcBcufz8qyNxQCbcE+kIStxIJ1OW1k+NsY8MMXtoadz7B1Xi9DHQv/Ei0
         JHDyPtnY0OFjFP5/QSW0tI3iu1QkacG/9z/P/F2OfsVE1Hx58xzXl41mpNCijNITGUGB
         gmhe0iob1exVEdRbOxKBPfG8a+YQ/DCf2S4AA9M4NhlIj193LzFqsPQ+IDkye8TnwDNL
         vgoaknMSUvhA6OpBxB5zzCJO56SiB4TqdPktdEm/hk85TixTWp6zsk8LUxPRcXmYcE+X
         xyEspj4oxQUw37TD9hF0yT+nIuW8NVPHtpPTU5Uh/FZbqzHe4Np2r2Px0RJJMk2M93nA
         L/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779317045; x=1779921845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aK2flb8TkEpF1bv8LHeBepy6NB9Xgn4WwtqvfFm6Yj0=;
        b=mtpUgNPByLmlWkkC/29kT8TYW3fI/jmtss7OEqH/Aj4lpNpuxtTYBwfxtHRDqnFgo8
         +GBlvt9Y/q2C2UdRGZq2WHKDEjpOhr3fHvGZGuFzP3622R+iOzShx5QaVN7Z+PxzTwoF
         dwl5sJ+GWWkqKl+27YDVh/8P74moalFX7z11b0K1Yz/z/iCo7EQ1BsfZft5tWFUxJxQC
         /nJ5tAHhWylQHDe/XEnYhQSUve2zwE9tpwdpotZMnNak2I7IsA1ooqaK+f3pRslpyRoj
         O9FfDcH9dPliERlU6qcQYzlbkQBxuH3yAskqYeMQtiIOGUe7aILIUjFl5qcHq85EPvXQ
         GMIA==
X-Forwarded-Encrypted: i=1; AFNElJ/15O6p4wd3rkwB/WU3pmMfoJ6iJfCjWeLKK4W/oKKtUYqVHjlZXNpt4AjHO5uSBfiVvHb5Eu4xfT3neMjB6qqH@vger.kernel.org
X-Gm-Message-State: AOJu0YzuILK2j3iWc2+eeB+aBwMc+RYsZNiF0i9mnM4vcICwaDJtc/Ze
	xgFB7wzNraQvny0RFQ1Fp28/79lLepxXavVTpd90ogDgKZ2MMRMMAS6m0040eTf3nljHcsE2zcS
	JQQOHlNzSjFw+r39jhYRKpv6g86+nlwP8tDKTkC34
X-Gm-Gg: Acq92OH4LlWo19dTq6naqlxjLg7nOUjHPwUYXjDo44+QOJL3pljmsdwV5gcImRXa+9m
	fIpIHLTeYtCN0pQ8W3jRHUSQ2YD7R8lFQ7MGg8a4W/qibuCFMBgq97Ppzhmy1KzfQ299iKb1OwE
	4vYNphJEMzatdEveM6rWrflZocJgXZxQER06QbE8OeeUnIggyK4t3g6B4nXzZo01STmjKVfjbC5
	Hmqs4wW+sP/2nwPylG89zJ9JonQSth2PhzemGLocpogfsd6p5i6/auvculYiVWEaYwzCvF9/q0a
	Ddx0cBw071VkLIndYW/ToLjKdO7haUJ+sWkh4pKXKa/Nqeha
X-Received: by 2002:a17:903:3d06:b0:2b4:641a:6b7c with SMTP id
 d9443c01a7336-2bea20bb1ffmr443705ad.13.1779317044795; Wed, 20 May 2026
 15:44:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ag4PpWl-wV7SDpd5@x1> <CAP-5=fU3HG9Mh3g+9JUCgkcE-DhmW66JSBnU5K=33kpcwhN0Ug@mail.gmail.com>
 <ag4ecqF1PZg_u4Op@x1> <ag4e1BNQlZWVWISE@x1> <ag4f1iYyHdkpToXu@x1>
 <CAP-5=fWtx=B56xy+dDK33E8VTZ+4gBE=nLNf6ZdVZyQoAFLE6g@mail.gmail.com>
 <ag4j-dzzaa2xMr4y@x1> <ag4kauWBogiPBhRh@x1> <CAP-5=fW5DbyqPJwxO87YQ4DC4bRnhXxCe93Fkdbr3RMjT8-AQw@mail.gmail.com>
 <ag4l42A5UJOR3tQz@x1> <ag4szmCZdWwqHR_R@x1> <CAP-5=fWoN5UR4xvO9MAE3c0kNR-6sURsHtdzAN3kkHUHQrqUcQ@mail.gmail.com>
In-Reply-To: <CAP-5=fWoN5UR4xvO9MAE3c0kNR-6sURsHtdzAN3kkHUHQrqUcQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 May 2026 15:43:52 -0700
X-Gm-Features: AVHnY4IgqRgK1mGUCC5PUkVf5N4jfpfRmuFI2rVaNh2aHxQHnTY4dJjEads0FRM
Message-ID: <CAP-5=fX5Tm8Hikaba63QHbWDsfZ6=cQc2tq1=F4Xbxgjb7y42A@mail.gmail.com>
Subject: Re: [PATCH v14 00/32] perf tools: Add evsel to perf_sample
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com, 
	ak@linux.intel.com, alex@ghiti.fr, alexander.shishkin@linux.intel.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, 
	blakejones@google.com, ctshao@google.com, dapeng1.mi@linux.intel.com, 
	derek.foreman@collabora.com, dvyukov@google.com, howardchu95@gmail.com, 
	hrishikesh123s@gmail.com, james.clark@linaro.org, jolsa@kernel.org, 
	krzysztof.m.lopatowski@gmail.com, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux@treblig.org, mingo@redhat.com, nichen@iscas.ac.cn, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, tanze@kylinos.cn, thomas.falcon@intel.com, 
	tianyou.li@intel.com, yujie.liu@intel.com, zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 3:32=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, May 20, 2026 at 2:51=E2=80=AFPM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> >
> > Everything is at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t tmp.perf-tools-next
> >
> > I also rebased my perf.data validation (that has some extra fixes, beca=
use... Sashiko):
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t perf-data-validation
> >
> > I think I addressed some of your review comments, if bored, take a look=
,
> > I'll submit as soon as I get what is in tmp.perf-tools-next moved to
> > perf-tools-next which I plan/hope to do later today, after the containe=
r
> > build tests finish.
>
> I'll look at the perf-data-validation branch. Would it be okay to post
> the patches to LKML so that we can get the Sashiko review on them?

In "perf session: Bound nr_cpus_avail and validate sample CPU" the
perf_session__deliver_event change appears to inline
evlist__parse_sample which seems unfortunate from a code reuse
point-of-view. The commit message calls this out but doesn't describe
the motivation for the change. Could we fix evlist__parse_sample?

Thanks,
Ian

> Thanks,
> Ian
>
> > - Arnaldo
