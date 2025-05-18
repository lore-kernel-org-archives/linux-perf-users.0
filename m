Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259B39FD9;
	Sun, 18 May 2025 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747592086; cv=none; b=R9RpQ2CyLkDL1aN3boL7jopfzpsK1Y5veJ9IPr9QF0dm31HaG5yzot2Dv1x86nNrWxLOSaUHv8O6vu8GCMvvOl2GyzFrNYHhsWh9SN/0/vuQGLSDOrQ7iEf6RLa7HpB5DkdVBQIcE415lAfNhn3JuVDc7W6Q8LjERDiu91Var9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747592086; c=relaxed/simple;
	bh=3XZqXp7z6xmhy+qESAoJBE0/Qm/c75kBrkL2RC4mJ9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNbQNjMVJaUjvIDn5zA9cL23plI+PKqKSCKAk+LySc85m/iExQrAzQpweAoPa+31CvyALkRNRxSBWMfnHOX7VYA5LYJygLVfxSPHTrnQOqt0vJkZt2+1Q51S/3AS1bYHpXlTFP5hjG40aY/jodg9hlUw4MvzBqbfp/dDjJ3V/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eeMetdAX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eeMetdAX"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-70ccb7effb0so3374617b3.0;
        Sun, 18 May 2025 11:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747592084; x=1748196884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyaRn8VkCxgCCGc7WET29gPJFWKcVTgXcDNhGYjKQ3c=;
        b=eeMetdAXY/4PfhjWoMnLb2unvXcf3odLGupm7VNwXD8j7uoxZ9V4aojx0PxEkjunRr
         PHmBEZTLD3HL+6PD7b/Dgvd++EP8G4g5EmSlqv7c/Pe+UDHXWY84roABtbxc0vH87BbZ
         oPvTR7fbp21A87oVoWtoMG3J2nWZsscBjRcFwzjbZ7dU9gwHSYa9Up9OHaWtdAhzIwPF
         4A1HDVRSy+2UHf1vbHraDJmdll7ar2qA8uy+4Wl6m7dK7uPa83XsDphX7t5pG6SaNm6v
         92jMEdmOBWFBPBw/uk8XavqV82nmKW0aZLmEapFOyaZBV3AnZz3xqjOsrVj1ZUMRb22f
         0qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747592084; x=1748196884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyaRn8VkCxgCCGc7WET29gPJFWKcVTgXcDNhGYjKQ3c=;
        b=uMPEXTnURXjCxjKcUUgInCy6syQyQHyI20DJdiJuz1T1Vw7nCG6MU3Kw3uzN/OUHS8
         xzPKPUo9UfZbLB9P2jM09KHSA2Q4waMHgeLPEeqMd/GebSMQzJvG1J2IPrLu0ZaLjdpP
         yjSXvC9iNCk33Eg0xb0UslbD2XYv6VWzip22RUAHiatnFiJhKIMQqkvF/a+taNubQwO2
         eprZXyb0Yv7umEFbRLzdbEWHSBvjBKvR/iVishHRyP6Zv4HksZzVmGiFJMb9sv+9uRdF
         mQF9Q5qtyWmv3bbEkvAFJLRGAGIZdOLSBUo1Hptdo6+2YqemUr3VmpIUSimeZQyFwhsr
         zuXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsnb0loBjV7G8W2jcuvw3exV4xY0wRLwhvQeoKVGOCPWg4MAOALjSr147aL9UUbsjFWAPUkk8jE1qxOLQ=@vger.kernel.org, AJvYcCXRqbNVvYWzeDAc5oyblfTIb9Z8gCntEeIZ1IooEX+2Z0lGudlldT0lTvzsrGO9wAthT/6Q84BqAHy+zC+7WG4edw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwYtZDKqOyOnLLK1EYRyRH1mlOSM0YLO4fpHvazhhjdmNWYUoF
	y06BtxEgigls/EEiuUrvc1OUWpQfK35v66o3CIMQZLPTVj6Rz/uI1aDReeq9cpPrPvOz/83R4TU
	DZJazKY1W4Rc1H9/P76OTiijcDzewAPA=
X-Gm-Gg: ASbGncvL+Kyk9KJ8NMfuQyVx1lti4uqpCfCrf4JF0pcGy1Y4JSV98i/gHRMZhReyH25
	+qGvP39NwddV/5qw06bQbxepe8ajZwvCm0KUsVPjUmZOgPAS+qP28e/kaCfRk+jrN6wxiDjVVUs
	wLZ5LkHS530hyNwDZBTMDCJAMx+1aSQBI=
X-Google-Smtp-Source: AGHT+IFWGjT6PCx09EclVxoZ1Fnk5SduO2JEZH/wt1gmeZZ8Dh5OQtWul5dKME8XTtN8PPhaXUPNhtGaDqGGo5z4758=
X-Received: by 2002:a05:690c:9b12:b0:709:1d50:87d with SMTP id
 00721157ae682-70ca7bade72mr155233897b3.34.1747592083894; Sun, 18 May 2025
 11:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517163230.1237469-1-howardchu95@gmail.com>
 <20250517163230.1237469-3-howardchu95@gmail.com> <aCoatnYe6z61xdcb@google.com>
In-Reply-To: <aCoatnYe6z61xdcb@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Sun, 18 May 2025 11:14:33 -0700
X-Gm-Features: AX0GCFsxSmPJdkdKd07lxTO7X_4UXX0noSOMax6KuF3EBhQA4NnSVjBx96V3IMw
Message-ID: <CAH0uvojxBvx0KC5xVem59zD8Uu8A883GA98uT1_tGdyYk1tqig@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] perf test trace: Remove set -e and print trace
 test's error messages
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Sun, May 18, 2025 at 10:36=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Howard,
>
> On Sat, May 17, 2025 at 09:32:27AM -0700, Howard Chu wrote:
> > Currently perf test utilizes the set -e option in shell that exit
> > immediately if a command exits with a non-zero status, this prevents
> > further error handling and introduces ambiguity. This patch removes set
> > -e and prints the error message after invoking perf trace during perf
> > tests.
>
> I think it's fine to exits with non-zero inside 'if' statements.  But
> it won't work if you want to move it out of the 'if' statements.  I'm
> not sure how it'd work in a subshll for the assignment.  But it'd be ok
> to remove 'set -e' anyway since the test checks the result manually.

Yeah it won't exit from the non-zero status from the if statement. Thanks.

Thanks,
Howard
