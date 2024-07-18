Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574DF75808
	for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338365; cv=none; b=mrfHP8c7qmYWNOYS+stt7AccQxlHtii5N6G0o0PiXrabWYlnWqq+0EVH3vLWNs0cpB6g6RJtj1BhxCPKQ2rHIxC+WH/8epeYE+CI5Z1HXvfuyQTUN/yfCZY3h4ibv3FTi/4cckUrloteNlR5kSsDaiZxyuEeJohF9ATNeZb59Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338365; c=relaxed/simple;
	bh=x+Grn05jYwFharmOUM3bLkrPXB4zOvjtZSG2fFM8kQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZejQ0yk7jR/dXjGrAVGJsLD9k9hMirSXGhZM9wCtjFUws7CAcsUnP9IRlRAqsQAGdYlotbLxXu5LzdT7DT8KlkQ/qDXOFNKQgLDZSPRaYp7LAQE550seqCeXcLjvmhPalhkeysstn6VG071Df1l0R0iUUY2n1QE3bPqS3TeAf6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7Dk+R4Z; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7Dk+R4Z"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-375fc24a746so11995ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 18 Jul 2024 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721338363; x=1721943163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+Grn05jYwFharmOUM3bLkrPXB4zOvjtZSG2fFM8kQg=;
        b=s7Dk+R4ZxazWVZSo2IXJp0jRnX/gKpnq9swmmKSIdtSW3zLoVYHVfJS+qgxNtmuqsB
         bdextBIVC7aNnSW1Lyio/Kp+JadlhXJqgDR5H8O5SNosbav59IBSZqTZdG8ayCkltnDJ
         ha4Sdj8CXnKqdw1fxVuuHmbMFkI8UlnQI/yvBVRUCVnmF+ZOhY5wlu4RoCW4wihCUr7K
         D04TkNzfmOTC/0VAizVJZKahGmUE3ywHsuQE0cvl4GdXgQ9wpwQHbe1duyZj1jE3puF4
         z9YDrJlzr4aUpXkQTI0vTDY6+Y5NPRSqqJR/SgcLHY2gpwWpcemSWQuQ81vPsZf4ej2a
         RD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721338363; x=1721943163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x+Grn05jYwFharmOUM3bLkrPXB4zOvjtZSG2fFM8kQg=;
        b=l7XrySc6gTCzoKuvdexPwlO+snxcJnEOfRZJSQSCk9L4Vu9kUyySf7u6lzxuqwFook
         KJeUeQqjcSuXjzA4DEylS35/w5LKIii46Am6Pak9jbgx5UWI80YNuofqNQN6JwDTGeHc
         /F4T/FZfrxWbl0ctuh/xyZjWhDG29mnN4DbIY/BCKVfnwGMGye0rpFaJ4HpGFjAOepXo
         N2k6MF7bkIiQtT9VBB2fWzrUjHhOHlfkKrm85UoiJZcdncNrA1uO3avnnTMy2sFgelwN
         OxRQJql9VJIG8yc1e7xm9+MVeNknKMm0uO2ZSMk7ZWpH3fo411flFsGPJOSawjFvXcFP
         XCUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrnfi+A3CT+uY52ifq8mxfw1SYoyWjJdVEwFvndA34hY1Z7zsYLCNkOIbwLMIUMswQFXqWThYeo721MgaC4cS0eSOdaEd7M+hcoe7YMxOWwQ==
X-Gm-Message-State: AOJu0Yzaa4n3gcwdMc1shk8n2WMsmvTztg+RjVBTPlX/8w3jXDD7M7fi
	wvHGUmicla9aJqxQdgeLP67AtLhfH0tjhHJfbkrw+5ccOCOE9Kcap5hz+puZFjHjbeIM0aq8GZi
	0UyfOv6QHk0Rzx7q4Ao72o5RdT/lAupXMFJzo
X-Google-Smtp-Source: AGHT+IESEh21K1btfGbjGglVd1NwrXMErmZEsuooTHxQCnf6aM36amGwZ2+P+nRUPQcZzjO2kJXV0hf4C69DvK55t9o=
X-Received: by 2002:a05:6e02:20cd:b0:376:44b9:c363 with SMTP id
 e9e14a558f8ab-397b611b2d3mr977175ab.6.1721338363042; Thu, 18 Jul 2024
 14:32:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fXOQxiKJBfzKs3Gz4DuMoxxoTWf-Hw4dKDbhRguSup9Qw@mail.gmail.com>
 <CAP-5=fU3D9YZ+O-Mm0CqrpY4Ubhe6qW_nn8NkjuQ_jfVu2-scw@mail.gmail.com>
 <CAP-5=fVF9LVxO5kpyutmbOTC31ywQCO-qgNk3qnqv5rVOf-JDA@mail.gmail.com>
 <CAH0uvoiCX=asogf6e4D8mZ2Yw+8pj3HMTyvYTtQjFTtgKKP6GQ@mail.gmail.com>
 <ZnRP4hJLcRpZzs4x@x1> <CAP-5=fVtutBamCT9VJNJv+nXB1VMBZ3V9ed-mAMtWNaVbygvHA@mail.gmail.com>
 <CAH0uvogumw30VSAjX_RmmxABLsvD_FhEUeUo4nNE6vwBNSni1w@mail.gmail.com> <CAP-5=fVNC-bBvkg851705msG+jA_Qu8HNPPX1evqDD6TM7ZrVA@mail.gmail.com>
In-Reply-To: <CAP-5=fVNC-bBvkg851705msG+jA_Qu8HNPPX1evqDD6TM7ZrVA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 18 Jul 2024 14:32:31 -0700
Message-ID: <CAP-5=fUSMDhooNetywiLfcYEHMPeyPaGHuBhJHUb34zM8DqtQA@mail.gmail.com>
Subject: Re: Linux Perf Tool Office Hours
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Office hours tomorrow as usual. Details at the bottom some possible topics:
 - update from Howard as we're at week 8 of Google Summer-of-Code and
exactly 1 month before the final week.
 - update on LPC perf events MC:
https://lpc.events/blog/current/index.php/2024/07/04/tracing-perf-events-mi=
croconference-cfp/
 - v6.11 merge window is open
 - PMU cpumask, event.cpus discussion
 - follow up on last week's python conversation

Linux perf tool office hours
Friday, July 19 =C2=B7 8:00 =E2=80=93 9:00am
Time zone: America/Los_Angeles
Google Meet joining info
Video call link: https://meet.google.com/tif-efem-uiq
Or dial: =E2=80=AA(US) +1 425-217-5482=E2=80=AC PIN: =E2=80=AA791 261 968=
=E2=80=AC#
More phone numbers: https://tel.meet/tif-efem-uiq?pin=3D2651187837256

Thanks,
Ian
