Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2851137C35;
	Thu, 17 Oct 2024 21:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729200095; cv=none; b=H5Mpegcjd9mh3Gh3ZsX3gh+VozgTzdpmeYmEjh7dx/w78DVvqb9Rhq5lQTnT2e3lXWE982SE2znV8SahxMgN3Mm7IQcok6yaC0mAw5W/hmvkFabxDsLe268WmJ+T57CSJgAehM965qbH4EWnqPvufWjQHyw/Aw2Bgg37jLCBifI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729200095; c=relaxed/simple;
	bh=JupxIBqBY2YQ9bKRrQhPGDGE/PRgKivFsQK1f5mq40c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1+/KIwrBLWaPtl8U3MSlxBUAwAkihNq4f6feTkiS1L8jrKYYEnmmwkH4LShaMbA+U0jbvhtOy6vlH4HZxZU/SsUENFptZa9enbMrvJt34Ur01HRIYt3mF7sjA6E2lbyrk1KQfhHsFLXFQEmJXi0hJvl+DUPZPXe/8oRxit1VJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkSmooE9; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkSmooE9"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a9a1b8d45fcso21586266b.2;
        Thu, 17 Oct 2024 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729200092; x=1729804892; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JupxIBqBY2YQ9bKRrQhPGDGE/PRgKivFsQK1f5mq40c=;
        b=XkSmooE9gswlGVHN+t2Jjzk4oJLbyd5twRILZ8uchvdRSIcWhd1J6peo6q4B7wnfVo
         6QwnXLtD9TgI38fdkk6n5dp5XhbZsoHtqSeS50fwi7mf+hj11McaAXoRRrrvuTJhQfAr
         qkXXyrfgrhltzsPeqYb+T1csK9OQ2Hii/BNgqjO4Wq52O2g7SsVFwNZ42KN1uE7UOfYW
         SRMFd+V8oKnK0ioVCOU4byUbcVgrYODay1VB1YrOgyjDTqLL4coW59hFf6vxF7EEGl7f
         Ap1IiY3aoPRvdQl+HjskN0DfVbONIMsiKgqkVEYZgWMu+AZU4w4KIDlulV09Wk2p6w9J
         N5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729200092; x=1729804892;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JupxIBqBY2YQ9bKRrQhPGDGE/PRgKivFsQK1f5mq40c=;
        b=Sfoal4U4VBw/OefhyCpLkQk6AO5652eKQOj4GGlb4P/Dkitprb9BC/LHBTa0b1p6E5
         p37ud/GVqRZSTCpY0zDrbmKXJOS2lLdFtCrmP70YIciZHPp6EgUpI8OzxjX+kWVrF3SE
         ZMb2It1Hh1noa/S5mpGSvqp7OYaY3iowyow1id2HaS/gum8siM9Xp/6UZpAtrZGRNrMx
         /o0ecXpa836vTKVwjjW3PomW/JKkKLmruegoADzx4ahcXTITaMOYL60L8h8fs5FaQGjD
         3h2GRyjggxGIEnLnzf4IJIGUSmDCr2Sg6CZU89N/A8NNgtFwWEIvRxrZN6gp75uzqiip
         ICFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEyKSc/4pI59hvBT21k0TkbS4sUKkK4f9Ji1OARc6Ju0Hl1UL8MM55hn26u+In6nBOXEJO9ovX/KNNyUY=@vger.kernel.org, AJvYcCXgj6yYV87zJCKPxGK1mRXKs9cjIRH8eFE/wtD5WwD6D8VtsT4vYLvY9UspmLXJDr+txAQ5e2ItD+n8gp+7eMgAGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2MjAXxCt2XIkcj3ZlQiQRyy+JupLz/QGaI6H7GLh6a2chO8Q
	I2IwTr3/oboRrEpDZhp8glXpaESY3o49OzBW9gKdfxqWk0RmPnT3Ge2o5j2/tg5+SuCYbq9G6GA
	XcM+n3XvXRglKtyw4Cy1lh0ca1fU=
X-Google-Smtp-Source: AGHT+IF+X1XELYaL+l8kT/yLBTPU69odgsfaUlCxjuqU7BiE+GqNEumtBo9+e2ONAaz38If3Qf76SpdWSiwpEta63Vs=
X-Received: by 2002:a05:6402:4402:b0:5c9:2a46:b45c with SMTP id
 4fb4d7f45d1cf-5ca0ac512famr49694a12.3.1729200092043; Thu, 17 Oct 2024
 14:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jzsPbjKkKmZudMvFJDnmBHhRrZqPLACs4NibLNdga02MQ@mail.gmail.com>
 <874j9wkf5j.fsf@linux.intel.com> <CAJg=8jynwj2SkEBYRM_XKs=zYh_wg5RKxMDTCOQxs5WRthRQfg@mail.gmail.com>
In-Reply-To: <CAJg=8jynwj2SkEBYRM_XKs=zYh_wg5RKxMDTCOQxs5WRthRQfg@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Thu, 17 Oct 2024 14:21:20 -0700
Message-ID: <CAJg=8jwkdSu=a+_1v-O0GqS2oYQYExwsC+uF3BFxTfUynv2t7w@mail.gmail.com>
Subject: Re: WARNING in __perf_event_overflow
To: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller@googlegroups.com, 
	harrisonmichaelgreen@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Hope you are doing well!

Quick update from our side: The reproducers from the previous email
still trigger on v5.15.167 (commit hash
3a5928702e7120f83f703fd566082bfb59f1a57e) as well as v6.12-rc3
(commit hash 8e929cb546ee42c9a61d24fae60605e9e3192354 in the stable repo).
Happy to also test on other kernel versions if that helps.

Please let us know if there is any other helpful information we can provide.

Wishing you a nice day!

Best,
Marius
