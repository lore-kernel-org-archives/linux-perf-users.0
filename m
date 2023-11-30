Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emsi6qyl"
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB86AD4A
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 04:42:37 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6cdcd790f42so882863b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Nov 2023 04:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701348157; x=1701952957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tcHPkRGiaMHrGBy9HNfb2vuLtolweLQ5VpDv8UoedYc=;
        b=emsi6qyl1tH6KWzAluxdVA8wKzidEvlLiABVeLHL3m4kQQUJOaS1UTFBU5p0fwkg67
         NdqI2S8JvSCEMF9O/+NPrH7meO9JQzK2Tk5EhMYfFaXfMkP9oISCLqUP/jO6Tpkv3PqL
         eAc9NHb8WgSSMT8qo85mPE3DIjfcG3z65gvVU4+swV/jQAxhRm+vPECEuaCK2UioSDzG
         vOPMiD/mpDrNB6PGHlcoOeHHzCeX3IquBMVyJ53r+cF/k2Gm8pwyJkqgozRSA1d5aONC
         qPBKK0Jim2l9PU0//xDl8mP4fdm9QjfdkG4W2QLdrAJ/pe4Ko6zzKoal3CYnEVxX+ccD
         GeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701348157; x=1701952957;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tcHPkRGiaMHrGBy9HNfb2vuLtolweLQ5VpDv8UoedYc=;
        b=Df0wH015jOePkfI5KKOJz6n9WEC96zfrCjYAr1p1DEYF4s1fLo7CnY3CK68+8+y4lw
         929OKj9jyYqgaArBaZVxo04Qo+dWR1gqmxblq0+TAcRH1y6OYI8BmIzPxXqN87D0iIKd
         rERKCn0dGGVKNY9KeKd6nIsJNEpRyicPDg0Me7YfIfT4616WzKvBtCyDyb98KIoHmjes
         I623L0RLAC7kjTtd3ywn1GYBRI2SH7CPIdTQ+fXkKDzxoqq8K76q5oZ1Q+hvgwO6qJAV
         sB7+90KgkOfxOahEjLOWI7MCS9RyMhVqsYl+rdi8/AxtCphxPXECJx+6WnWkOtueVKxc
         Y8Hw==
X-Gm-Message-State: AOJu0Yxapv+YDbpIza+AdeuzcWAJ8HrH17EkytOxgjEOkOjdwHMT9pHS
	gAYmS+aljKBre4Dhx4ECPLU1LZaneosZsewwuiecdb4nUHc=
X-Google-Smtp-Source: AGHT+IH8DNU08nEFnKWEJhL6d96g6Gehx8in2nCtf3Y951WKCtoiadJUxwNIBoN8Cofd8HWfm/zjJFOfIVxL6mZlVFM=
X-Received: by 2002:a05:6a21:a583:b0:187:636d:a61e with SMTP id
 gd3-20020a056a21a58300b00187636da61emr26392428pzc.42.1701348157053; Thu, 30
 Nov 2023 04:42:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFjbc8G+q4sFpO5D6PqbDFNbHHpgYZ_2ADV7sUp7Lw=AefprJA@mail.gmail.com>
 <896b5786-8ed7-af6c-2c64-a24bb06a0d89@arm.com>
In-Reply-To: <896b5786-8ed7-af6c-2c64-a24bb06a0d89@arm.com>
From: Pablo Galindo Salgado <pablogsal@gmail.com>
Date: Thu, 30 Nov 2023 12:42:23 +0000
Message-ID: <CAFjbc8FXJwJShr88XUybWFQa1HC6rYdq7cpc3XPCuPKjOUoz2g@mail.gmail.com>
Subject: Re: Perf support in CPython
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Do you really want to use full Dwarf mode? You have to save the entire
> stack space on every sample for that to work, so it seems a bit slow.
> But maybe it's not an issue for lower sampling frequencies. If the
> application has a huge stack it's not really scalable.
> Is that just so you have a mode that works out of the box without any
> recompilation of Python? But not necessarily the best way to do it?

I do not *want* to do it as we already have a fully working version
when frame pointers are included
using the perf maps version. But the problem is that users cannot
generally leverage this as most
Python redistributors do not compile with frame pointers, and this
renders the integration useless
for most people.

So indeed, as you mention dwarf unwinding is a suboptimal way but it
will provide a way
for most users to get the integration working for them and people that
really care about the
most performant way can compile Python with frame pointers. The
problem is that most
Python users do not compile Python themselves and this is a huge
barrier for them.

That's why we want to *also* have DWARF unwinding working, even if it
is suboptimal.
