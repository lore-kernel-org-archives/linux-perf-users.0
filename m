Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3C41FF61E;
	Thu, 27 Mar 2025 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743061354; cv=none; b=h7hKdnQif5sFKHUIoiYdigBpDlVQ/jFM3auoe7rnFiE73JVVzC0MNSQGArGEPC1m667cQjUiMbP3yHoPw67ix2EVdB/YgbHTeMQZmMURoroOpellZ66dFdi/wrULl0qvyhloR/s9K7ir4QISxvXHhEL4aHlgpZrGRy+9gsxkuJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743061354; c=relaxed/simple;
	bh=q7NeFXJ9rwbCmvlzRjV7jXpL0xDuIPxqNiRMU8J/mA0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrbZeyPaQ/mtSKWgfHqu+cZyarqiDvuIw7+Q0yMacbeefipFjkc/UFFM2hAgP/UdyuxrWjzRFdPYWzp3edWq13X5Gb31gj+tU7CI8T/+Tf4VLhtYNjNv7tDAtcc48MQWC94l9bMlkXVXN3zhMgqYQRtnpp7IU/cymmVrZPoXdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri2/eF02; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri2/eF02"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e53a91756e5so663627276.1;
        Thu, 27 Mar 2025 00:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743061351; x=1743666151; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7NeFXJ9rwbCmvlzRjV7jXpL0xDuIPxqNiRMU8J/mA0=;
        b=Ri2/eF02+JZD6AZjoGver43jVAU+c0/nR0uexe6opDYX01R+g4380SVcWiJUd+RIPB
         ZxyqQbri4GsS/DWH1LnNeVtB7eQdl1krhAFb1xidNDkn/JhJUGSGLxWaHYAtjG/uztyz
         Ebvi7UiQzYLDusBfjEN0IO8a5sZDybbU77M72Yiev+sMiNE60EnydN4CfYqV6iHBJ/hp
         zgsB0Nyp3+BKUksH5qZyI+LCS01f1VsJKZVJBbiF3Gzsn0GZFRrpGgmtFVt9oVzDl0hn
         U1ytT0E1t7e0DWzPfbGBjCTScUnl+E9VZt8WxYxf+9PsY5GCUShVLNY1QMthJNgVvfD9
         BQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743061351; x=1743666151;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7NeFXJ9rwbCmvlzRjV7jXpL0xDuIPxqNiRMU8J/mA0=;
        b=GKnsyuVO+IGOHxLbsA2vLP2lAbkopF5/YVLVq/2fQPu+VZw6ofQz39LQHJlff7HX4l
         zfYE8KOS+UIemuIA7Yl+xnLxZAageFMyQtmOWRWbRsz2MW30wHZGG+PpjbWyHE20zvuk
         Id1OQKFNkqE7xADppbz46U8hjpBcWY2GeRGryohnksWeSN978qQBpgxBzujjrWp/WeGA
         qbiAWDF0eC8XrEwIMmWxEG34aUQNUrFEvJBL+auWUAO1LizGW4vzvxrc5ayQBvSNO/jz
         7ZXPBWQrSKngtFQzgpFiXqVsx0Gv6BfTvylYHTWbX8OLL4EJwHfj5JcW25Jt9Ci64zPi
         Y3Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU9abv+/9xY+5aNzp5Z/+IirdD/P3SxqF9iix6Vv5MxKofsSY9Ynpqu0J2d60fVb9qM75JRLb8FcTyrDTggzldcng==@vger.kernel.org, AJvYcCVHYH/S5yrF1vIqtLWtiW8uS706byrWRuqV6zRQPF18BdTukttEjeWjLxzVav5JzQUyaja1LQJebQTkBrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0JuhU8WNAnlj5M2+HxXM1BFEv7jGcetYzrin0EZfYLoFOeQ2P
	iwZI1l+baCQwzXzVEo/8NBHJXeMgyaIVGf+/eFjP4LDYbat/vL+SR0Xa0hUNzPv0yJvIUrFH0ZC
	4hKgRnTDHrznHnxWsn/5Gtb+cb4qlZOZCG4g=
X-Gm-Gg: ASbGnctqbg64W6oj1/ByLAPS+qrMNyRbNwyTYldXFK7DubwxKTxBpV8Djwrzt6WjMEx
	CKcvzWcE6ovt0hZRoeMJ2xg6VG6f3lV5HSI/6i8fy70KOYSiLEf3lFeCM4eR9VTXgA80Rl7JdjG
	74fkdVNJHFDorO1Tzh6oONcWOa
X-Google-Smtp-Source: AGHT+IG9LI1jdrLieUXberqBDDg/+vOh+gDvn4YdxMDM8fjwzAohW8PF8IvkYaqWgB3lostWYegIdXGlE6q6JHZJEVE=
X-Received: by 2002:a05:6902:4889:b0:e69:18e6:66ed with SMTP id
 3f1490d57ef6-e69435d3a5dmr3326818276.24.1743061351372; Thu, 27 Mar 2025
 00:42:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326200540.1843856-1-howardchu95@gmail.com> <Z-T7VohMjkNolhCi@z2>
In-Reply-To: <Z-T7VohMjkNolhCi@z2>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 27 Mar 2025 00:42:20 -0700
X-Gm-Features: AQ5f1JpB-0hagE9pe5k-mvEvqQU-_zqd10JD8kvDpGjSxcQZZtA3LWXXlzBzAk0
Message-ID: <CAH0uvogXtHTUQ_-itb=4_nDM-Nb+s167mY9fDgJvW=5s9Bm_kg@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Fix possible insufficient allocation of
 argument formats
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 27, 2025 at 12:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Wed, Mar 26, 2025 at 01:05:40PM -0700, Howard Chu wrote:
> > Changes in v2:
> > * Simplify the code (written by Namhyung)
>
> Please move this below "---" after S-o-b tags so that it can be ignored
> when applying.


Feel like an absolute amateur here, but can you do

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Fixes: c7b87ce0dd10 ("perf trace: Fix runtime error of index out of bounds"=
)
---
Changes in v4:
- foo

Changes in v3:
- Add Fixes: tag

Changes in v2:
- Simplify the code (written by Namhyung)

 tools/perf/builtin-trace.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

So version changes between the '---' and diff stat? Will this apply?

Also please ignore v3, I missed your first message sry.

Thanks,
Howard
