Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793818468;
	b=KDAGy965wzs++VSAxhBB5Ccx73QQEmgk/nebw4d1co6DIs+AokKvtjKMwJ4LWsfqrjwm
	 HE1aNoydaIjPrUA5S0WUdTEnGcejhcptkDAdx3xqpOhnjkNwf/RWaZ5vAYZIcdZ4cbIZ/
	 Ol8Fn9W0R9uzyhPEnpJmHg8v3KVPMudeYatb7dr3WG3V2CKT4Jzxh8n5iiLqSBjD/zdc1
	 o+aZ4LhO+cEm4sstdrEM3jQM0mCQZ2LWV9CK1+53zh65vajLU2toepPd1TrKsut3RS7nd
	 fG4GjOtIPGyoeO+ikFdJgTE/HzzbuLAInt0jbEG07w8u9xjtarXyqK83m1qRYj0A90Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+uQ0/+i7Rib4A9xdMc9HRUVG1zZvttqJsRXd/p7RWSU=;
	b=zyJ6ECsqlEJRUwmuz5tWb4PKFWyu07kYdxoN5h6uJsxLqW4sPHPY2B6eCZKf/eaL4XXR
	 XUmmk9ceAkbVqEi6prZnh3/PdDx+jEwy+dp30j7ryG4jnpX6yr4ORQMjbSAM/DUEPcxyO
	 gEJzgRdZCkcZjIQ++8fQxYtRBQXROPaewWViXTVf2O3NNCfjzt6/wYgN9kp2RR4kVFwwh
	 TUJH3+AnbFJ3raSd4JosVv/NZ4VZiPMwMQJYq845TtSQ8ircgF0oKmp0cZxf9Xg4qjUCX
	 hDQloaoavTzrW7rFeT9tWp/u9ST5AnomknW+zXyF9GOgfK8bpkko/uDOaohnQnS/vyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="gacQa9/v";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC486082BC1
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 18:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CC486082BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gacQa9/v
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ac91f5aa89so10055291fa.1
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 10:54:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793818467; cv=none;
        d=google.com; s=arc-20260327;
        b=Q2TrdX7xpccjlwemrZVpRb9gWt78Fy8A5YoqJnx6NAcXQAoGl7w9sO3olTCzE39+qX
         XdIld7n4tEYiMXojmQ35gbghipNf8LjAEo9WJ2WyIY+YEys23ri2+u3m9IvWMXeG+m8g
         sZ60NbPHK92ZrKLhURX0wzna5iBo/6QO0hviy8VIiYnTvWkiVZbAf5eRrZKlhwMwlrPc
         9aYTDqHDjbCOSgSUO5r0Q2sfBkOFMPfYD9O6UwSEgBp+DU5tD+dRl8tgOj1wXGThokbR
         YmA1yqtB8QtUw9ROchHChTE6VeTMsXAf7nK15skoNH4XmtMCFl3x4oSMlvWOOnymjXo8
         20TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+uQ0/+i7Rib4A9xdMc9HRUVG1zZvttqJsRXd/p7RWSU=;
        fh=HDx76iXVgC56D2FbrtX4wFkt6QkrUdZi+Bx4NpaRlTw=;
        b=lEs8ooG6sgdQnvzASZ9SGhT/t7pIZiar+fkbZNA2+LUiL33SZHubIuLzUHU5JKcDkb
         ng8JjzvYqqJTJe3x4pTDuZ5nLgYJrxaP1KCKIvB9tqwZU3oK72BWHNVqMBeb0jSVkvK9
         4jMZh4AF5/3yyvPL7dv5Xp9rDoNJkvY2c4n/pwOUK6bGRovVT+x88igVJGUj4zm6ttht
         cCj6qut+noLvx+O6/3sGYpAn9ipvJ/428xCn00ut+E0LKZz6UHh6+HLUIcoljAcBf/17
         NnkrP9Qf3uOCzqUbwaZjevNdbUDwQ6M1o+CHiCcY6HofAfwQ1qTUPOOxTiC/dIf1Y66A
         bnpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818467; x=1794423267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+uQ0/+i7Rib4A9xdMc9HRUVG1zZvttqJsRXd/p7RWSU=;
        b=gacQa9/v1244DuV3ul3QkghxUOJZc5CCfhqJ0JmuY6OAdKOmEY7KWaW/X1IfSJF7H0
         wowY/q5HyT0D6fMiots80HQrC5oU1FZUTwRiURYehYYtfNuszMNqiD3aTAvmk3xA3Ruu
         nWCqUmqbfu4NVIgCPkoXT0awJEk2AJyCCwep9d+AFalK0q0xz/FcGz557N3qvw2/i6qB
         fIQOWMaYvyxTl3PL2fSERaiW4D+cd2Uzx/Oe/laZh/zHkbWmJ+RN79xGwTbMy2LqO/xm
         HWzQwf555u3GkfTEmBMnOfEQ/3SaW8/z2bYxqgp4pcp5bRvwN+Jv4yjWtFWqcBdsg+/A
         /pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818467; x=1794423267;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uQ0/+i7Rib4A9xdMc9HRUVG1zZvttqJsRXd/p7RWSU=;
        b=bZ+M/SemzL5RFjfiTkPQQoAGs5vo8JVdMpOsyKu01Q9T85ST3I5fasTJTcRKySSVfg
         /bJ+LyM7iQbxqKJBEEsng0/BrUs9qjULURcw2YG5lcl2Jh2KxyH77B1iIGkC06sd+bqc
         q3su3nzxHE2uHB5aXdSEKXXK3s36hKOVf7vwwRaSenvYe1BbG9Xljk8Ewqlo3m1v7iSJ
         Ojg0fFZ27/yeGG9ly3z2PNXOmjLCNWz1wi0cahIUrWxGNMiRhjvif06kv13P1JEWUN2X
         gjkgp+fSfdj4O8V4Ug9tAQpaIe582AYtTBfjipfxDlkj8PGeyjKYjNC+ZO6RsfmRcBRT
         xywQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfpoxjTDE3LTpyP5fj4b5Y8XYTsVY5Oo9NjWIT3ZNLF2MTRlcdJt8c/5tnQ+NAcI3wq+CNS2RtuRcwKMXQejlM@vger.kernel.org
X-Gm-Message-State: APuU4Z+tK4HMUx9KQpTt/jkhcthJZDYCwKirG7jfd2Xv0wg0rn25wDmG
	S12HxVOmfp2lav4nEdya8axDBMCYx0OTdCgO0lWw/45CS8Ph3cdLluQAsQYx9p0zhEo0tZF0rOZ
	/VAwF0YBu12vfPrychTdRzjjsAqUUjiA=
X-Gm-Gg: AYBFou3HTVpfUdYgw4BtkxBjkCBK/iLtZ8upOeDdVbnw5fgjzvSSIYDv4NsRgxpPtAY
	91W+DrzkRoR9na7C+98ZS7pS3qj0WqlsYCdHTR82O6lswVkQt6SMjnWQJJzOHPwHv5bQP2Dhe4c
	HMY9Xj2fvX3a4hYvkkquw3pZ5PMJvSDsiWmYszd94QVPGhtQDwh/2AIMrLJ+RVKVZUH4hSC2i1D
	5n9E8P6JTMmF/uE5iQwSuOZCdt4VaCVbm/mychDaC8fikTYzQ7GpCxM+rCG69fTWXnp6JeTTIwV
	Z2yBBwDzISyhxZOToQdUFaJlSu+ifIKEHw9jDc24zTL+7Byt1td9lv8RuuUSimSNbc+NTdwI4OK
	iBjMKot96bu/uFABqRWofAEWk4J7LW4YqT+CsKTgQdAN/tutNZSJ3wClYLsdM+pV6/i5SaAeI1Q
	fwJjGP/bfGTECEEbL8suJ1t4yUwMkyrRS3j6UeoPwclWJzNNlN92ZH
X-Received: by 2002:a05:651c:150a:b0:3a9:8167:62a with SMTP id
 38308e7fff4ca-3acb7b6498emr46627851fa.28.1793818466526; Wed, 04 Nov 2026
 10:54:26 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-alpha-profileme-v5-0-bbe3937fbf3a@gmail.com>
 <CAP-5=fVtMnaoF1JbVFJuiRqPx-2izJafs=+ov6eF_PYFE9Xrxg@mail.gmail.com> <CA+=Fv5SO2NF6834Dq9pV5tdLrECnV4-1oNPJnD38+Or9u54eLg@mail.gmail.com>
In-Reply-To: <CA+=Fv5SO2NF6834Dq9pV5tdLrECnV4-1oNPJnD38+Or9u54eLg@mail.gmail.com>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 4 Nov 2026 13:54:14 -0500
X-Gm-Features: AclHuK8nm3ftnjmYgdiV6kBSrHAe3PMoyReSVVB67Kenr_T0JJtD2lmIa1lZRcs
Message-ID: <CAEdQ38FNa-7ELRuDN_N+Kw3eQ0oQ9WWQ==fFULKc50Bx4nCWdA@mail.gmail.com>
Subject: Re: [PATCH v5 00/11] alpha/perf: add ProfileMe sampling
To: Magnus Lindholm <linmag7@gmail.com>
Cc: Ian Rogers <irogers@google.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 4:02=E2=80=AFAM Magnus Lindholm <linmag7@gmail.com> =
wrote:
> One detail on the wrap check: alpha_perf_event_update() also advances
> prev_count on an ordinary read. Should we cover the case where a read
> has already accounted for a real wrap before its PMI is delivered?

Yes, v6 handles it. When alpha_perf_event_update() sees a negative
delta it adds the period and sets a flag in hwc->flags. If the flag is
set when the interrupt arrives, the handler adds nothing but still
takes the sample and rearms. Writing the counter clears the flag.

> On prefetches, the EV67 HRM, section 2.6 (p. 2-23), says loads to
> R31/F31 may generate exceptions that PALcode must dismiss. So seeing
> no Linux fault wouldn't by itself tell us the access hit in the DTB.

Right. I didn't go by faults. ProfileMe's I_STAT has the trap type, and
on the EV7 a load into $31 that misses the DTB shows the DTB miss trap,
same as a normal load. So the prefetch samples are split into misses
and hits the same way, and reported as PERF_MEM_OP_PFETCH.

> I also checked the saved ES40 recordings: 344 of 266425 samples had
> both PM_KILLED_BM and TRP set, and 53 of those also had MIS set.
> That confirms the Python decoder needs the killed check on EV67 too.

Thanks, good to have that on EV67 as well. Tools v4 ignores TRP and MIS
for killed instructions in both the script and the C decoder.

v6 adds the wrap check as a new patch 5, which shifts the ProfileMe
patch and everything after it up by one, and most of those changed.
There's also a new last patch from Ian's follow-up that lets ProfileMe
events take exclude_user and exclude_kernel, so perf record works
without root at perf_event_paranoid 2. I'd appreciate another run on
the ES40 when you have time.
