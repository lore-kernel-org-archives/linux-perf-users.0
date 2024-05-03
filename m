Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4FE57C97
	for <linux-perf-users@vger.kernel.org>; Fri,  3 May 2024 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714708851; cv=none; b=JAseSz6tBXBbSGtDG6y+NsI25rzQWyDSgIDfnnfmwxydbyY2HG3dT0xt+oTrlv0jgVoGqxO/gqbJk7xfLwGmjVm11vKihjTpQibYbdIANzHq7E5uhDZJ1xeuUZZCW2AUem0D/O+835DOBoALGrm5ODlCjBaptTUB3yphwwJdQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714708851; c=relaxed/simple;
	bh=dxd0KtYZuDHQD4ZtOLTNNbqSEgwTqHeGuFqN832PcuQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OaUUkh6vv+WX1JwyA865NZA/QUUMp9vM19oH5qKl7EtREzFTbHBDtQZUOBzCn4f9KJJZAGs3kStZs1VqQgHwZsY6DO4bZ0IFORYuf2AWB+oEd6QhuY7O0szJ3dvb9D2ftzFQVKHVCsPH25sGzrfcYLnmmTamFmDDzDq2DnFHwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U8QyAd9a; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U8QyAd9a"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-436ed871225so149301cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 May 2024 21:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714708849; x=1715313649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dxd0KtYZuDHQD4ZtOLTNNbqSEgwTqHeGuFqN832PcuQ=;
        b=U8QyAd9aWmpbOan2jabc4vmh4JBarZElDfnl85kyfO/9FWmGXBJyxZ683yZyWgB5IO
         FvexBK1sMbPCBo5YwhDYR8rRxjKXLNeYgsLOHx+D3worzZGD3POfVzLGq+yn04zPOy60
         5dpqcQX2JwzZVOGd4Do4Bp0aU3pCoyCpemH5U4+k6FpMijWTcDfy3kYAVLRMqImQoV42
         QdXID8WyiNzhnjR2fl8c4bP96FqEDNzhPryOhm03HnBC3L27L/6SatRqOfHaK2Cy+VRT
         f1UGQnIcEwFsDjM4EF/Pivy8tvppojtD9JdxtdUv7H0Ovf5VOqs0mGozCLYsgR9AwEyE
         laNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714708849; x=1715313649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxd0KtYZuDHQD4ZtOLTNNbqSEgwTqHeGuFqN832PcuQ=;
        b=UQulIzEkWD2qLdvDCugkwcUUt0xskN5bW/OcPzTLJvWsqCkf+Y/dchHfGE2m+yTbd+
         nxzoSZ8EiMW0KMTdMRUyLe10o0sPRFmsJtoC5fMK+cBYfMV9PePFSgLbWak+fZLDdeH7
         gpWCZSJP8HrWQqF9jarGbWubCU/bbY3A4TrTxb/YA3nH/3wrM2OhvdQ2jAjny8vwMlqg
         AfPiiyvr3uzHbGFndKITIyjUhCV33HiFLvQQ8MSjI+OLDQ+UzzUVr0fNV8PT6TRNW30h
         nB+I3rG8ynuLC4p/2m+miNuv6wfLoBov5H5B6iw2SJeqxcgdt1caT+j6oA4+DzbzMxX7
         yjng==
X-Gm-Message-State: AOJu0YyFZSM2PSbTpyS6pIaPDxI7ReqpRU8hRUBagd2I5RYa9kRqfwP5
	5mXUVLrkFvcLQ4ZSODTOjCfimPqNs6nWX97pSOOZHW7IisGHGpby5H/gtbdaWFDv/rp51YXIZlG
	jGxbF08Pr1PBjIYq4FTjvadECYdsmSefzdF1nTVq0DMvlW6IopXcFwdo=
X-Google-Smtp-Source: AGHT+IFVfnBWDxxlrneerSPGXZd11uilHqDDTtTWMHsfheTRGjqgSm5mmzMMB/nd4NtHnwndRdyNnWBQKv9NTps+K9I=
X-Received: by 2002:a05:622a:180c:b0:43a:f821:5b17 with SMTP id
 d75a77b69052e-43cdbdb0c68mr1157471cf.3.1714708848612; Thu, 02 May 2024
 21:00:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 May 2024 21:00:37 -0700
Message-ID: <CAP-5=fW2-pbOek68wjrEB+G=kzDmo3oPYuFj7iheouTMiaz5rQ@mail.gmail.com>
Subject: GSoC 2024 contributor news - restarting office hours
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Cc: chu howard <howardchu95@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear all,

We were really excited and grateful for all of the Google
Summer-of-Code (GSoC) applicants received this year. It was the most
applicants for GSoC and the most we've ever received for Linux perf
tools as part of the Linux foundation. Given the number of applicants,
organizers held proposals to a high bar and we're sorry for all those
who applied but failed to get a spot - we tried to argue for more
spots. You are of course welcome to contribute to Linux perf outside
of GSoC and everyone is here to help with that. Thank you for the
contributions you've already made!

We are excited to say that Howard Chu's proposal on perf trace and BTF
for GSoC was accepted. The GSoC program officially starts on May 27th
and now is a community bonding period [1].

In the past to allow an open interaction with everyone in the project
we've held weekly office hours/syncs with GSoC contributors. The
office hours have often had wider discussions on perf event topics. It
is difficult to pick a time/date for the office hours so if people
have thoughts on organization then we'd love to know. Perhaps we can
alternate time slots, or have more than one. I previously did a google
forms survey and a timezone convenient to Europe was selected, but
then we had very little attendance from people in that timezone.
Somewhat selfishly this time I'd like a time slot that is convenient
to the mentors and Howard.

Thanks,
Ian

[1] https://developers.google.com/open-source/gsoc/timeline
