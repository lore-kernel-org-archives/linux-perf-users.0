Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481483A7F59
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770665125; cv=pass; b=liHTfAv3IHksMqTd5wIFzLw6vMefcphGOrkNFRme93cA08vdbqBnNbZ0QLJf6oROWOUr0DpcvY1g857YynTV2jGQh3UEkU0mPejarQsw+oYWWGi3uV9ra52yqPRxqz4am5PEExXOdmdLcgjHeRioeOtxeplhvf4B540rmxGXKyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770665125; c=relaxed/simple;
	bh=UsUROEyI0bzZFzQqIcC3YQdhyLmPXbvyNRNxHMu/2bI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CCZvyuIuG1RYjtc/y1LDMCrseJD8JngGhxwO7Mty7dtp5Zwe9xeEhcLPabN9JEkirdF4a0O5BiYNQcIdTTI6iwB4L0eL/R1h5IN3uQH3tQy+tcCct6AtnuAc57WU8LQrUnQH4SpOTkgq8MQ1211c4TEZsCPGheTLBfizImDn1l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5m4yYcj; arc=pass smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5m4yYcj"
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-409521ba360so40905fac.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 11:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770665124; cv=none;
        d=google.com; s=arc-20240605;
        b=eUF2Iv+4OMwBfOiXz8rwsHQPYtuPglb1UEKGyqrCjRw5idDElcCE0O2dYthN4dqeDK
         q9jq7/hASXfm1f1GiyN+xNAUS9vO6JLltlc7jeiiVyjte8nSs4pY1JZvTjMBvt3C2N6y
         AgZWnyAKLDpNufL6RQ5iUXJr6+sHG4KQnrVIuXKdaD7rep4PU7GmiKGDy6C5JjVOinne
         9szkVnu9pLJPGxGL/KSJYCefO+RU20FdpE8172cAqKyLOR1mqSrn1x/rxMGgACUBkxJZ
         Jm/VXhfXb/0fwdOwFEiIg9/GkDsIPsbnGr8SL8/2Fu7178ZDLWXscahYtaClhXNqdnDy
         L+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UsUROEyI0bzZFzQqIcC3YQdhyLmPXbvyNRNxHMu/2bI=;
        fh=lMJYVtEnsy49Bg0/NSsv5jAYBTSzyVXIMvWZltXSsDM=;
        b=jFP7JRRJnklvcOmhfQ1oZzxxpJ8t8tK3LQaOpH8jl/mQd5CGxV2vKrH7M2xfFIVljs
         Gd8e5acSenmhBJHlctjJ8G6CFSFato0hb464uRmINtu8NHFRXvcIXYRYo9dErzQJiwAQ
         uYSwIPXtu5Q0cdxsZGaC1yLF47iMwCMr+SaWH4OHfdqilCEQG7NdrN+Q8LulaghSTI3+
         b11xZfoYrItnxlOQnI+VkPiD8R73GcGgHJpP/yPhSmIzrJkmJU4MyYQsLuRc9ZytkHLP
         fXDXgmODHt+AwFL/SaB72WLiC1FwCuScNkQY4AoWanzUCtFz088p/U8Vg9BeUXgGDw7a
         A01A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770665124; x=1771269924; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UsUROEyI0bzZFzQqIcC3YQdhyLmPXbvyNRNxHMu/2bI=;
        b=M5m4yYcj5OdwUXZB+/BsBU7K1N6gbZOK+YbJxJfXErjcjglDR5d3DZYmQCBmAA84KA
         n9FZTAfAPdQ2oJouxM71GeI5ktGr1+RA/gDzUDoND4af1yQklsF5+JfrcrZr+l+XBYTY
         fDRmjHWZQnOG6mDoCXbuK/ulVawLdD/Q9jyC9Qr5n++wwxspB2I4ZaUo780Wu8Y+xXgV
         Lkecq+bKVo0a2VhT0AjXzjvl/0jWeqFAxh+jSFkuk5BbPs2dlkMq+mdkDXbkOLbj27Zy
         OqV9O4+00Z/5fnxN7lWWgLctonKhFgZU2wxscwaooHgTCd8WaSkZnnPQWPZ6sBvWWBLn
         ZTpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770665124; x=1771269924;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsUROEyI0bzZFzQqIcC3YQdhyLmPXbvyNRNxHMu/2bI=;
        b=W0jaihGP+UPtQp8NTVGwVXGcgXAg+M/9BsjfZRQniHZg88gIAfk4VSuNSuGDaEdiGs
         ZRVdZL3fZqgZK2ZQZUBcO+BQMyUlXKxnAy5RFL6doOM1XRo3gr2mRpQkJDZVY7BfmFw2
         pX9pVDqqEPVxw+/BS9SUoCKx+8MO9UmXe5VI6VcskdG3nPbZc1XaKQwWE75yN5qYD7Xe
         7DKWDOS9B1mF5tn2wqesMLNKsoL4id76wzDFYar+RwvNofq2XqIfHUiKF6UUxjuObZYP
         dZ8YpDssV20zQQ8PFWzpfLRNsoDEzOKeW65KwKOs+9ihH7vMOHRCr/0wzM+zXvsRenYd
         Prdw==
X-Gm-Message-State: AOJu0Yw785b0uJ/SCEaG6r6WzQQZpR9fIdepipVsy4xydVnWP2/3CjiW
	yN/ZFyDnBTSTRWJPXb9Pu3YpjwxKEL9Rk2arLZOVh4ARhh5yZcWvqCAhoNhzCFKP5nhZyYUAQRs
	BKg4/waVuvBdGDPwaBD0F99Wam6NH2qPCNvQ2
X-Gm-Gg: AZuq6aL1tRoJmzBGtCL6QVMsjiqD5j4JLrSJyfi8YOv/pSjWrgVk74lWw7MROcZRzEQ
	q8Lk9ADDgd836kExtnGr6AOnwZbj0Ovui7i0FoRXHWI6GxOZNKQE6C50RfWmRU9k85WI/KAP1dV
	07rhbz3+gyrmLIXmwJCwpe/J6/COYNbrthksPfZac9CU4bqybOr9rtq9dIUk/WCkDQzDuT0EfUq
	jUZZ9jAXc6VBye8PtJmrVoA7r4H41IyPSnI5EmFfXX2ZveC3OWlSVNdUEvWtBVb/zWA2nkUQl7D
	CVktI67i7bM7fvQtUtbgz662VYRce+CTJgsG1eOJ3WSovwgYlBU2Ij8=
X-Received: by 2002:a05:6820:4cc2:b0:65e:f7e6:438c with SMTP id
 006d021491bc7-66d0a85af4cmr6163866eaf.36.1770665124041; Mon, 09 Feb 2026
 11:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Noel Grandin <noelgrandin@gmail.com>
Date: Mon, 9 Feb 2026 21:24:47 +0200
X-Gm-Features: AZwV_QgL9ggtzu2NbMo-1zloHrlitakySPkUtu1B6O5hpu4cz3hUh4ySerwP7Wo
Message-ID: <CAFYHVnXddP=V-q=0Z3Na1FOBaQRT3RA55ruDY=O0pNpbaSc4jg@mail.gmail.com>
Subject: why is 'perf record --call-graph' using addr2line?
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi

I am running

$ perf record --call-graph=dwarf,32000 my_program.bin

quite a lot.

Until a couple of days ago, I would do this, hit ctrl-C, it would
finish writing stuff to disk in a few seconds, and then I would
proceed with using KDAB hotspot to analyse the data.

Then I did a routine 'apt update' of my ubuntu box, and now....

Now, it takes 30+ minutes before perf exits, and it is spending all of
that time running addr2line.

Any ideas?

Thanks, Noel Grandin
