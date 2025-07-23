Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269BD1DE2B5;
	Wed, 23 Jul 2025 04:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245027; cv=none; b=J2T5RXZvkUSJK895k8FDS68onJ2jykc8Qd9CjoKvBPHsAlmCDId044IQiq0vEY75m+nCt8xt1GEAN26ka26fNtpgBL6rnxYJzhE+B0JQYOnwYNrDGZ4gKzP4e5NtUxC5Le86vpmh9c86krpyo1l7v4EZuyZTrshieBvn4gRu59g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245027; c=relaxed/simple;
	bh=quI/5wpXYhqn7ByVh2CJr1oQJ6LrSdYEfbFpjuMd1SQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0smvW8/bU2FqC4tiaIh5eA2GTijmafbOuy/OA5zrIRAxTeSmK3Z+51jqIs5LBpVFoeDtn+EQLC7CwX9yXAHsX07TyWBUqXolKs/fF9bx1bflq1BhISjMNOgXCkJhaI04XwkGnfsOBhil4vVIiJxzo6YHEe8dQg2zl1su1mbk3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G83yGNEv; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G83yGNEv"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-617a9a4e72cso264898eaf.0;
        Tue, 22 Jul 2025 21:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753245025; x=1753849825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UjIrj9dvcwAg12tvrhZ3N3eT+o5fkgyTGQdmK0bjDss=;
        b=G83yGNEvy5lCQBFm8T1fPIoex4Mg7RoX6HxvM0Sf9R68Ec2Y+bsBS62cHux8UtZO9Z
         YYxCwEOWCf2pxDqxTbLSSoEwZAnauD6NjUbgqyO09RaeKRG8t+Z+TE7j6qmvj/0OkIXA
         kH/eWZC0GfegOP2IRjMZ95g7LO/yIDsrR0KXinCIthN1o9uGibz+91t18ylTE0CO+jNM
         A15JlMX12t4zQWbScift9rXgr7W9w+P3ImFGhDh25eSP6kFufs88y3OOH8oUjdOYobrp
         O3NcTJe3k3fuyBG5uQvOXAovzXR0sXUOTmPi7FvwGW48q1ht15OHcBiDw6YBh2oUltw9
         ayZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753245025; x=1753849825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UjIrj9dvcwAg12tvrhZ3N3eT+o5fkgyTGQdmK0bjDss=;
        b=pSxVDue9TfzcmWacjy0rXEYd7GF5RtaHz18vwrVX5sSsPTP+D/PRd45tbVig47giRE
         iJtoK6gVEP+UXMeKHZuj99E6qCJUcO9M4LEhGknMyH+3amI31TmmITzvNrd7CAe5/JZd
         GIezITaosqqxhE8ZIPAlbTHw+AvSBVGKYBkb7AuAB82HgUylvmavvjlFOeoOmxa5VT09
         8tGoN/eLzzlDrQ6FIm7RSaEoKGtdjcl4b9DecEzY8/7FIu+bhkGxEkRlIFgxWCJd92YG
         jTLGtxrFmFrnYTEJ7canoYqVx7CgXqy2E9Y0+dAJW7Ol4/7Hx/9lpbY00FkS50J/wLj1
         AQHA==
X-Forwarded-Encrypted: i=1; AJvYcCUSEY4XP4JxNxHv+aWdAH64uToBzJ8EYzp0il59MsFUujHojFgszpksLfZTm9rHuxIkyiFxemHCcY0lErILWZrUnw==@vger.kernel.org, AJvYcCXqCd0VcAkQCczVBClvALsS+9GUhtnWHL2kYMGqX1J+t/J9DTlAK2vVE74BJ03bJLDswNX2EeEMw9ybYZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/dJzjAmaA7ZhWDjKQb4ggIqxYWF3jG+iBtvpl+5KNJy381XbS
	nAe9a3nxFNoJn3FzQPiVWQ9Cu2DdkFXb3FL1Rr26Alk8kt4xjQHBShrjNWJ+HPve0+ouE320C5a
	M5uH/iSpkFF7oY5V4dG+T1rtOWZzvViY=
X-Gm-Gg: ASbGnctlq0ir1ELrsU20lQeVMdHJsRI0NS/jN5rOQrvWLgzYW8OQWgr8LS9nt7rnHhi
	CsDegC3stxojzlxy0Mjjmhbqzpu8KcLB+HpiS+ALEfM/ipjabSzMMYGBlRUTUhmQNC3YdR66r7w
	LR5+YFLAqDbTzautfbiqiX6CfbXXXZqCg7jfgnNlls46bfRz548bfGrLp9Zibgg4KrKZbrqvPLm
	bcDOwBKrfCKexRi5aM=
X-Google-Smtp-Source: AGHT+IHffH+4XXnNTdbK9V3u9aXUfCukWocuYXmvOdWhcBnstZYMkc+dPvZEjLcDwnyfl6ApmQU6vR0T9FNwZ9TPslA=
X-Received: by 2002:a05:687c:260a:b0:2d8:957a:5166 with SMTP id
 586e51a60fabf-306a79e40e7mr3742528fac.4.1753245025066; Tue, 22 Jul 2025
 21:30:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720085905.192652-1-suchitkarunakaran@gmail.com>
 <aH20-KEurjw5qJq0@google.com> <CAO9wTFhdgHEFQDVt2715qP6-6bsE9+AeAAPYe4C8N1mqpy7g=Q@mail.gmail.com>
 <aIA3JQWNs-0Jsla4@google.com>
In-Reply-To: <aIA3JQWNs-0Jsla4@google.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Wed, 23 Jul 2025 10:00:13 +0530
X-Gm-Features: Ac12FXw6tjcCmuWShRS-j5n_GRl69zyL-KVPRXRf0ijlFBoiw1pK2k8FHeLmGHU
Message-ID: <CAO9wTFiH-wrvAgwUhPH3=a-K5HDODzuqe1+4D+aigxe5J_dq6Q@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Fix lib path detection for non-x86 architectures
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, sesse@google.com, charlie@rivosinc.com, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

>
> I'd be intrusive if we create a new symlink.  Probably we need to check
> if there's lib64 directory first and use it for 64 bit build.  But I
> feel like this needs more testing.
>
> Can you share what's the problem exactly?
>
> Thanks,
> Namhyung
>

Yeah I agree it needs more testing. And yes we can check if the lib64
folder exists and then create a symlink. If there's no lib64 folder,
we can create a symlink named lib64 to the lib folder. I assume this
will cover most of the architectures since the lib folder existed in
almost all the architectures that I tested.
