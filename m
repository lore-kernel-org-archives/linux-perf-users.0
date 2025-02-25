Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5371259499
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740465071; cv=none; b=BouagHXWmGRPtUMWK27Fe6JL7Rgk7Tn/xqHOsgIQ4Ii+n8m32bJm+baTVMHtZNR/3Z91HVuTpCub4YvcWWiRBuxsNq0sy9H1FjC2Wql5iu+KYjWLZnvjDVB83CzO7eyBlTzfVQ7yk4v4WCa/y59UYV6HaeXnyqwYgyppyDmi2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740465071; c=relaxed/simple;
	bh=hObuqr58Vys7yvCIUz9aDi5+qmfGDohQ6KYOsjWCgm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdVg01mUQaX3Q2w2XxLzXRzJ0j3LkpRxcuGVgabLYp2AFJZJceBse+04Wx6VE+l/tFU4NfPI8t1xOnfqdltBEcjGk/wA6kD33FfGF1xGNRYpRZuZcS81ZNCjMDlkHe1nEradHANYw3MNzFCYr1rVxilTViQegMAKa0z8hwSqL/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xpowKU6/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xpowKU6/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e0575f5bso111745ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 22:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740465069; x=1741069869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B89x8UxUtUDBpdRWHV+ScsYjiWuhgi0mOW8ExhQoZ9U=;
        b=xpowKU6/T7oJ2eo8y9xAg8xKMHK4aLFUkuOJ2TA5NtLUYFN2btN13dW650UnTOITaz
         w1bUrpyhjxvaxaQAypMDQNYrPLR69UkDX1j3pX8hhy8DoaZqCnzKcMxzRMSTi9RqVMqZ
         JLdHIEdo2qJzG3cCw3deM9NxOL2dmu8JQKCEMlgPE+hTCHtMFLecAFDAYVRSS/3zj62/
         bX+6ETroJOF/PkvdHTPaqXPGUqEApNwlNAhoihMPQ0nJIorsxPmaD1e5clxI0Ju8B0Vk
         zVybvjAXrwXtgLcobp9PIB9WomF2MSCMENu/MWtW4H4pnPh3GZJK1tDCIdOfc7Wyo9xs
         bZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740465069; x=1741069869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B89x8UxUtUDBpdRWHV+ScsYjiWuhgi0mOW8ExhQoZ9U=;
        b=bk7r/K0hXn91LjuBJWAIU97xKRsuoPAgurISVi7nvAslvwqfQpaqprdBCjUo6AIuog
         +kh5v3cCrFSuUN/5rXtzcdN/YImeaRNhi0nj36jARa70Zxf4DD0PcSGln0YONKSiBC2t
         yosh4edHkTQj3UVcZLqvWqPzUCgNFubuTEkHZF7BHlaztqrKU+NJcX6OVhtqyfvNXmTj
         2bakJ54dtGNvt9/6m3twK+EK+p0/UpADib7oVPQWAVRj88DDdDAWRtEioryshsJCwBZF
         dAqARcrJv3xI7bl33KnADJiVqiEk0DYl4hcv4VZQvH18TGi+5/NlUkJCnaQLZ0BuF2n9
         nX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhyrTMs4nmTqxtd/Pn/USJ1doqo/mtLgtN4XfhVicjPep6y7Fx3YVzSUpVtaU+V22GlAmbNJUXGhUR7VFQvI7D@vger.kernel.org
X-Gm-Message-State: AOJu0YxUsHZ7/oTWzKVqK+VX0gzO/u1g818E6ZSvBpMqFgzhf3GW1u/q
	0Kjk71bqhqqFSzaGXjV3a7Hxcw24obWYuooUyPOoOkTnwD7588w2GqjT3MYP/aeCtUeHQZRHU9l
	bZ7TRKU0vV3dW9lyh0t/aHUAtLKcbLlkUISy+
X-Gm-Gg: ASbGncvcUvFtyHaTN6kLFDcZNC7NNNGevEJgf0wiuXPPiIXUA2X5DM3SKtHN3G2qhnH
	qgTsdbESyN6uqBnIHmXhbVi9eRTHk6B7NxpAfcgmtsl+Ymv2mat8dUR+iBOMbl1z7gcxDf5LAMu
	LAdso84ZUk
X-Google-Smtp-Source: AGHT+IG/cVq/zgRr9ZKtB+tC0r+WKjogtfFF3yKm3sbrXczDnxrbXP6eWeymjeRSi3vk7pHFaO/1Vw/RG8zdJVtc7TQ=
X-Received: by 2002:a17:903:2346:b0:21f:44eb:80f4 with SMTP id
 d9443c01a7336-22307a2e210mr2213605ad.4.1740465068875; Mon, 24 Feb 2025
 22:31:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <CAP-5=fXL=nS1-m1+gJsYfWfvyn0ouikX3=RvyKdiM7+ewS9-mg@mail.gmail.com>
 <CAP-5=fU3beskCJLQdKE8Mjdsx0wTiihh7Z9k7VQtZuJBZC5b6Q@mail.gmail.com>
 <Z6pWj7jlH6ucKXDu@google.com> <CA+JHD90PDGA-Zbu6hUZ1DZQbSD71FBPRbBdGd1dWCxhi3q6Q1g@mail.gmail.com>
In-Reply-To: <CA+JHD90PDGA-Zbu6hUZ1DZQbSD71FBPRbBdGd1dWCxhi3q6Q1g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 24 Feb 2025 22:30:57 -0800
X-Gm-Features: AWEUYZk2tqNh9d4T7EZXmVbwrzS_Mujjt2E5f47ad9PQ0SZBD4nQ3dCMAYZ25yI
Message-ID: <CAP-5=fVu4GzCv7W1x3DBdpq2cmHKepxm7Vq96VJO27WyyhiVig@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Python improvements for a real use of parse_events
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2025 at 1:52=E2=80=AFPM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On Mon, Feb 10, 2025, 4:42=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>>
>> Hi Ian,
>>
>> On Mon, Feb 10, 2025 at 08:06:34AM -0800, Ian Rogers wrote:
>> > On Tue, Feb 4, 2025 at 2:23=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
>> > >
>> > > On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.c=
om> wrote:
>> > > >
>> > > > While parse_events access in python was added, it wasn't used by a=
ny
>> > > > python script. In enabling this for the tracepoint.py script a num=
ber
>> > > > of latent bugs and necessary improvements were discovered.
>> > >
>> > > Ping.
>> >
>> > Ping.
>>
>> Thanks for the reminder.  I'll review pending patches this week.
>>
>> Arnaldo, can you please help reviewing this series?
>
>
> Sure, I'm getting back to doing that, more slowly than I'd like this time=
. :-/

Ping.

Thanks,
Ian
