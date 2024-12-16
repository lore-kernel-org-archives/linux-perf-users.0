Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A579C205E0F
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368222; cv=none; b=BaOG9t0mw37hvSFu+qKVUCzSqmFIERePg3ieykHwYwWJtdO6fGvLJZqi71tVee2vkiLJmmOx/64PqaBbSI/TQzfqI7AOV5kgNQPhDzuRc86zrcDPLYJt6QfAsDpJD2v2ekEbeWg+8WtcmX3mJ9oMW1n4Dag105b8o9yq8bEld48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368222; c=relaxed/simple;
	bh=tUN6QyLrUQtqswwv+FWZ6ZBH4o75Y0O/ZF/rjsabplQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Nhk5EbhzacCc/lonOovFrXfoX7O7HZ+9vfBtLU6cQPFPKYUAMczWCj+JE5Xy3lAQkhsXoqwlc96giTaQJEHPThE7cSQPivDpoaDUXfQmFxxWQpeEhKHZqr+dReMm+cZzVxoxzauyag63T37UNg59X87vSpb3GiLR05zcW+wTSYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vkk1Pycf; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vkk1Pycf"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so350235ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 08:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734368220; x=1734973020; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUN6QyLrUQtqswwv+FWZ6ZBH4o75Y0O/ZF/rjsabplQ=;
        b=vkk1Pycfezmlwrvk22zev0avWgwLpfTXeZQLZz83AbQ1URk5LPT+41yyvWYUXXToXg
         ZyFLGp8gIshQhVLuCuPFNkgAFp+41+wBvpTOiO9VT0Vp3J/cwoKuoJurKDxjif4kih07
         nxV6H+7lIF6fMtWWPiO2I3FCzz2vZwHTYUuUwzd++nX+oFvjvvbkEivtWoyah0NCSW6d
         Db5JKq57LS6E4ZhQBZ4sxS/VcZCTE+y0W2A/WngBk9QEj0/KZkgFV4qD37IJ2Hv3PZmJ
         0j0Jvu8JWM3BvkqjNnRZwXYwWV+tUDKFpZMwVTHDemKh4DO2COUS1tHDUtTn+CK5ukKM
         bfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734368220; x=1734973020;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUN6QyLrUQtqswwv+FWZ6ZBH4o75Y0O/ZF/rjsabplQ=;
        b=CilqPTS1aN/3YLHo1XlUfup3hqvXwRWBMwOER1/DT0JJ3owSLRJym82DdzOWHBotHz
         AopRTHJiMKmMPj6+TqlRsLX0W4AyXUKG5fjdtcKeWek9B2+EGSWH9tArKOm5y6cjXqQb
         jil+JpBQjZI0VKMJ/Gi4yQd30q6//mV1GcGrueXr8kS/visFOSXvWzSXA/GxmhJ5n4AB
         0eaJozQNwTH8mE510KFxjKpVpVeHQZJtQd7KxEjlmj9pqJxmQ8uVVbQRU0nd8ksodWis
         qEcGQmYoUzTV7Z+QjieexKdadYoRqvXDOIE6Yz3EPjfuS/EO0/BsnUd9Dc8vdRnGiToe
         UJXw==
X-Forwarded-Encrypted: i=1; AJvYcCVeKQcLax7YQ5LYz8tHQx2HyZSnPlidWCxe4W+qgE9kUz9CC0UKQRzyDawmirOfQ0VhSrKkzGitHr1hJDPeVehD@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1MNH+uk6bfJ5F/7i0F1CAeaZqCLYKJfGyk0yzuxxgdecG0O2
	y6x1LXTrxUByLeVPWWwIK1U/4QJi0gVuspMgnNcefOY22jmEyF4FK/D4vSDeUSSh4KOLrnkYs/M
	zlLfKuIrAwAMrwubuUSTQqbaHcfgILny1xz/b
X-Gm-Gg: ASbGncs7UUzY2JcaJocuSvie4spWqUvQomZKtQm4eVKVDJIrgnx5n8Fy5bLib2AfgHM
	1nI7V/GhHpBPCuwv9xpzQNqGAoGIz0tvceWFG368=
X-Google-Smtp-Source: AGHT+IFenKD4P/KhIiSws3yn5GuMSBGYBSQhOYwGdU+AxUyjmLfeKG1/Yy+/zpPC+OKRBfJ/iyoKqrB/AotlSl2jNqU=
X-Received: by 2002:a92:ccd0:0:b0:3a7:a468:69e0 with SMTP id
 e9e14a558f8ab-3b2c2a279dcmr5132185ab.1.1734368219531; Mon, 16 Dec 2024
 08:56:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216014637.304761-1-irogers@google.com> <20241216014637.304761-2-irogers@google.com>
In-Reply-To: <20241216014637.304761-2-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Dec 2024 08:56:47 -0800
Message-ID: <CAP-5=fXsO2i6UE6FrQFLOyJP4xbH1E0-2W5b1ejN=MsGs0d0QQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf header: Write out even empty die_cpus_list
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 15, 2024 at 5:46=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Reading the CPU topology is tolerant to the dies_cpus_list being
> missing by using the feature's size in the data file/pipe. However,
> the feature's size is just the header size and may be
> unaligned. Making the header size aligned breaks detecting a missing
> die_cpus_list. To allow the header size to be aligned always write the
> die_cpus_lists even if empty.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

This change breaks the "Session topology" test on ARM with "Cpu map -
Die ID doesn't match" . One die id is -1 and the other is 0. I'll look
into addressing this in v3.

Thanks,
Ian
