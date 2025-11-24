Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A027472
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Nov 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763970700; cv=none; b=dFr/RLlM7z23zlT66LunYMwa/5OTpTMpvBCEQR0IsCZTyznx/zIsI5ttMQjFiD9orEpSQIK3cDPtt7Ud4BS+FScgsjAwfrfLyE/KovcFBDbq7wYllXkP+4HU7sgLGvAns56fkHRJ3LeXDZQprYN4/kyvUxYKRxDnq+9mD/oaL+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763970700; c=relaxed/simple;
	bh=NkwFA9bt4PsJVA9p346GsH7+NKsQSScbU6yQvmg4UlQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ri5XV+w0IVHQIwTiBRPvVjIO4rG2Up3n00gINDuZpQgsmJol5tpMVlKZitSVRJWKOd37maVJelVB14an5s6Moi9i77ABUHP+v89YCAVA/dR2BlaHfDR+FX5e+38yZiCry6YCoVxR6+9+botdeuwyqW9tkqBYfjCyIguoL3p4Gwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sc8y/rYw; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sc8y/rYw"
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-595819064cdso5555079e87.0
        for <linux-perf-users@vger.kernel.org>; Sun, 23 Nov 2025 23:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763970697; x=1764575497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NkwFA9bt4PsJVA9p346GsH7+NKsQSScbU6yQvmg4UlQ=;
        b=Sc8y/rYw0nNTz+/PNcMIldzRMNq2uRYmVwY4OrStwR8HFM2oUBXvKNg8t4VmYgSKrv
         rmhb/smDyaYLqAFP34KePpnzvqKY1pd10+0/NSZJ8HQPvRDXQeTa2AWR0en8xqeiUxob
         cXudesq8zWrbLHjEHiXTm4ZTspWyhFJX0QeIT3jDyFcTiAoPpgOa9BGjG+TBi6AdjnCV
         1rSN3pbIkGc2QPOU511Ebp0A+BNNAukOczjimiaDR7in3KL8YYYvjc6kbyQksfqNF5Ul
         oCwkiIw0VgCDc4606KD7fVmHzSp1gdQnf/76OTW+QaseG2lqQSH/YJw9R+O0EhU/oGkB
         Ti0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763970697; x=1764575497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NkwFA9bt4PsJVA9p346GsH7+NKsQSScbU6yQvmg4UlQ=;
        b=UVg/YhLUDqdHQtKyPCWYtViF2x9jwMgAFzpEJRlSukCzZ3P3iPSz0Pj4eli8uerKOf
         WyqEq+8Tr5C7+jEAqQwOlbayH8fvfZ1sS0nUDhepsSOA5U6xPnqKzTlohb1lbR2Ibgvb
         hL3ab/H5X6gk19vHuvDgAtvL94HTOGm5B3gY5UNRgvWHt9X+b9DDNH78sLL+wKTUnxTl
         Wa2pMJrimORCJB9pvJzuB1czgjbsLaYmJGdT2VbcEMQ6/iL9ZyusIxhQUbRR2jIv3hv2
         OOjgYOr45PhQN9FBkeqeS+tZZA482XMctkYVX2nXTWPn8cvR/4zxFGI4LaltB01ZiYuH
         Lv0g==
X-Forwarded-Encrypted: i=1; AJvYcCU82vM0UnGUr9CWyI2snnOuVvh9CJs574OrTwA2GA/Lk4s/B4zHWEkqoNV5OuOJS60GW+7qPbtKLGaYI/kP9rQA@vger.kernel.org
X-Gm-Message-State: AOJu0YzS13Nqm+dczi0FHb3PhugkVvoSEZ/wdqIQpIaRsNvibWvrTBgN
	zCSATSTtam5W/ztKdvT0oxwrOcy7l0axl18da/5Ll5UA+5r7xFcz3T+mzYfE62XI83MNw807E9z
	KDMshEqryTzwZTwVuPvKoc8k9qeXGZWiA4JyM/q+5bB/m
X-Gm-Gg: ASbGnctsEhIm9rW30XQ2DwDeV3AyqvPAF332f0QxSrIbYzjNUlyrlm3eEy17y8O8vzr
	YkNceUeKbxoM2dtX8NPrK9LOwsTWfpdO89wcAiYoZ0tI/2dBLxnze9ApolnE9uK8NSVT6gDpYIk
	Pmk96ASJ/Q5QUuSMYyVB8SVyw0UCe6ep6Pc1w/3u59poS5FixWLKlA+wGlaEc680gej19L88kdT
	cIFKvXGWeN6MJc7L4vF6dxiFfSoMeiRfPFbs5mpmlsDkXZ8B0BFrfwo+VT6Iid+GCmmAm0=
X-Google-Smtp-Source: AGHT+IFvR9jt6zmhWvSf/yJY7DFqxsQu8rC/ZW9fkca6tsO60TxVs1xtPM9NEnCg9D8LH94U3JlX/SIzJqjEyT6GTjE=
X-Received: by 2002:a05:6512:31ca:b0:594:773e:7631 with SMTP id
 2adb3069b0e04-5969e9df185mr4428263e87.7.1763970696453; Sun, 23 Nov 2025
 23:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251124072310.3592-1-hupu.gm@gmail.com>
In-Reply-To: <20251124072310.3592-1-hupu.gm@gmail.com>
From: hupu <hupu.gm@gmail.com>
Date: Mon, 24 Nov 2025 15:51:25 +0800
X-Gm-Features: AWmQ_bkct2JGhMwqYp0FsD8DCDAJuZSg50hSAXixkZ2WVGtPpGcdMp3zCOm0rsU
Message-ID: <CADHxFxRX2=Mt+BGhpCU9WfAMi9rfUO2x7qLy8tEu1aiSVo39bQ@mail.gmail.com>
Subject: Re: [RFC] perf build: Use self-contained headers from kernel source
 when compiling
To: namhyung@kernel.org, leo.yan@arm.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	morbo@google.com, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi All Maintainers:

The background of this PATCH is explained in the email linked below.
To avoid potential disagreement from submitting multiple PATCHes in a
single email, this email focuses solely on discussing whether to use
self-contained headers from the kernel source when building perf.

https://lore.kernel.org/all/20251013080609.2070555-1-hupu.gm@gmail.com/

Thanks,
hupu
