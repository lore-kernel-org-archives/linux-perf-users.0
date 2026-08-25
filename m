Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52F38944E
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787675937; cv=pass; b=Wrflk5xKKwnRcsqGyOWEShcgDCvMbf+v8FuJcO7/Gj8l6nCYkQ9yHJK7WFLOxMhFIUsCUowilfH1SucEuoIXQ/qP32B50FMYLkuI5uFfMHy41A7F6yIIeoBnh0jZ4xt0WF+2MoCP/3wVXvIS5L+G4ftJW4pbP9Xl+2HGR/F+P50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787675937; c=relaxed/simple;
	bh=OWo2nKnB4qmmON2XuWKvkiY0Yi8O1pI6igbD89x5D6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUj4D8E4rIR2S2nuSYeDpYLP03OsBLmbDRXTfWVYrG9f7JK3MKbQcc+n+uwSA1qwdvKdZ/8w3ERpHZkvG1kyWTSSt0f7XN8zG8oN1g+MeZKRt1/OE/OFXEsgqTSzbLQLk0ILK9DiQRQI0F/krMuNepKMiOZyHctuZsgECmFqWLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrMf+8Ql; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrMf+8Ql"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so289364a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787675936; cv=none;
        d=google.com; s=arc-20260327;
        b=G0rzOm8KDHuBhdRlA1vIvFQ9VaM1/Jo9eyoKr8mbq0wQmgXK/j3aGP0PUVgRWxZZ/m
         SHGxDRo7893vbMIH5NIs3vTEgCVZsijzAnZrRa1+zIWVg4n5tGmYh25VoIrMdC5jBF9Y
         q6lr2cdqCLAg3dpgANDiE3UM8Dck4Uo6/YQZMmcpv2fPt0CVNF/eVCdMMotI8G9fo8vq
         XimXw0SxqJ44/mBJi5FQPheu6NB0BtUeUMtYnAhpUjG5sAxzXmgxyjjWRnImX0WsborV
         aWD7IAPzAlR5DORSI6nHzI3B6EoZYpNdkL4ZV8f2jCXvQe+9VOF2gjPHokoQX2rI8rAK
         1Gyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWo2nKnB4qmmON2XuWKvkiY0Yi8O1pI6igbD89x5D6o=;
        fh=NYmeY1eV1CDj5EqIWrKwdK7ShgkTrAWCFefrpyfOGqA=;
        b=o9VPckysdjxY1XCFml/9PAJyZlhEAjZgsf0/d+ksdvX194Yp0MqZ7/6ra8qqthw5L3
         GD0mn9BmloJ9tvQ3CyU63qKfKQ3Ak/G+DWakR9g8NqI3khU+EQuRaPjhkOmhLrYAabM7
         p4nFVujs8bvz0kcuTo2LocFFADiM/gwoWkdjruEGZ0BqBzUtK7+XHnR5wQFaHAGZSOnH
         5NJeJhILbqAyrdoUg9BqNZsH3rdNlD8Ft6mFxyIVbVEO4Pny9YLMTiCrIJQE7nFd5rzk
         L1scdXFO+4w1RiVarNnrb+59Lb3SJqW/YSK/+vLyGLb7Eaa2zCNz8AkgVxiPXBbYeb+h
         xv7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787675936; x=1788280736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWo2nKnB4qmmON2XuWKvkiY0Yi8O1pI6igbD89x5D6o=;
        b=VrMf+8Qlta+IekxL+624dtrWIpBWdagykY1PdndSNl/tbEsJbJkmWcOum5uUNZV/0L
         YrpEbYYuiXz7c0RXKdw61ybsWtqfJhC7xEpaULvnhTjC7iXTIblm/6B3s0CxVaVFnPIb
         eVoPvfw6RnfRcDtwbu10nkXvJcifBvSEaDjloLpwEgtukSWWuDXazK2cuXkN4HMFsoag
         wBA5A3EniZtN4PIVKAS0b0v9t6w7cbk5lpRK6q/64TcCF4o/bCVt7Ehcynnh+5tEQN9D
         dBceOzZSDoC52tA3GAz+xpxSh+DREu8rDag8eZ80uT6zM3QUt29NuZ0SaexTd0Ja7n+l
         QjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787675936; x=1788280736;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWo2nKnB4qmmON2XuWKvkiY0Yi8O1pI6igbD89x5D6o=;
        b=Our7+QOXTXW+krD6OFy5h/5XApYyfN8gTIohf46oIJixmy+XihPKHlGzv+oAB07GqD
         Myd6kulDkSje4pwLhmUnMQuiA5sITOwc2ZhjC3ijefQTKgzOw+99BdQcthsCSzJ6+e8N
         J/eSvnFUSD15jM1lgE6SWmUDZDHbr4UPNVmbTcT+CR2ouzKnD4DNEODlXmuVOw+Kblgg
         6RKTzui2vHEPVGonrMcnHKDQNho0zQG7QHO/sRA8+JKW4PcNoH42c1gOA0XuvfXXEGWx
         v7noHB+eyWenH/hFnSfLZhLIAXmRGxv6TDY5/2twKAmV7OP+hMoG+XYrJPS26639nw5o
         VSGA==
X-Forwarded-Encrypted: i=1; AHgh+RowP3cPnEoaeqUXRHsJZYGeqJZPMl1PLb12j1ucmXsXtNhNwWRzwwys2RzbBh76WfVUh7njCke9TixYbRlsKalr@vger.kernel.org
X-Gm-Message-State: AFuF++knkmI1lXzNLeRrS6IA1y3Q3Fp7IULo/pr1fi2V2JBuPFgFUwgl
	2H/dwDMjl5DAj463NXJ0CZ0pD+MThOOTVVA1oVaNPadvsf3eerJEKc4exr+S0MlS/tYwB/XOhee
	NNSeFgqiga1vpwel9GXB/w+z2Bk2JNKw=
X-Gm-Gg: AR+sD13XIhwJO7c6tnluhCkKPHg8iv5Kdh+p/oX4tIMSorRd1tcnKDMjAVFpQuLJ/mu
	Kn2TjkOzAJl/88y+bPWBDYnYzz9S30lDDYRI0vmpmxqV0uUJjYcxmkivLyukz53rDwnyR2raNzi
	XQe8Rl/pntmiS/KkR6eSmEX3JgxwVzGFRam2+uHLUSj59nWI/o71ScfMs+jsLFS/wp7M08MALxa
	PckuLt98rg0S/h6dNacFbvgupGq8POQ58GTMycmzxFZJnKQ9FXOMVlKLB2eIJW09imFfAx/EWGS
	AVj7lattC9V6Xr2VefEosqby4bKaeKfwjJqEof4RYmePvDL3wk9ilQmsiKHuhTcn5q/1vGodxp2
	hx+F7k5v14dyTeBtllAcrnP2/sQGdfuraCYOjA71Neg==
X-Received: by 2002:a05:6a20:7288:b0:3c3:6b6e:8ba0 with SMTP id
 adf61e73a8af0-3cd3008a6f1mr59176985637.11.1787675935767; Tue, 25 Aug 2026
 09:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com> <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
 <aoxp3Rcbp3fUuqS8@redhat.com> <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
 <ao2KDQuBMNtONu0K@redhat.com>
In-Reply-To: <ao2KDQuBMNtONu0K@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Aug 2026 09:38:40 -0700
X-Gm-Features: AcwNN1V0hdtX9Y28fQcJy3eV8oSlMMr7Yb44xedm3cg9kk5uXBgObg30_PxA8NM
Message-ID: <CAEf4Bza0Hy_a4BpFBrsP2F5wvEDOyL6n2jK5FK8r-QyRFwvBPw@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 5:27=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/24, Andrii Nakryiko wrote:
> >
> > On Mon, Aug 24, 2026 at 8:57=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > force_exit_sig(SIGILL) can't be ignored too. But I am fine either way=
.
> >
> > Current SIGILL sending is already pretty bad behavior that bites us
> > periodically, instead of doubling down on killing the user space
> > process because something about installing uprobe goes wrong, let's
> > think about a bit less destructive way to do this. Mark uprobe for a
> > particular process as defunct or "detaching it", or something along
> > those lines. But not just kill innocent processes.
>
> Well. Yes, SIGILL sending acts as BUG_ON(), this is not nice and

The problem is that this is actually not a bug but a very real and
expected behavior with user-space using fibers or coroutines. Any
suggestions how we can make this less violent, as it's actually quite
dangerous and kills production applications when someone (unknowingly)
tries to uretprobe trace them...

> probably we can improve the current code. And, just in case, as for
> uprobe_copy_process() in particular I agree that Option B (make fork()
> fail) is better.
>
> But what, say, uprobe_handle_trampoline() can do if ->return_instances
> is NULL? Either we have a kernel bug, or the probed task does something
> wrong. In both cases it is better to kill the task with pr_warn() and
> generate the core dump.

I don't remember all the code paths, but just shooting in the dark
there, we can always poison a pointer to distinguish or something? or
just assume kernel bugs do not happen and ignore NULL. Or something
along those lines.

>
> Oleg.
>
