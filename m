Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BEC17A2EA;
	Thu, 24 Apr 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745519547; cv=none; b=XHrrVKPwMXPQh84kH8T7KwdTfuFQU04F5iA9eVKUbG6rt/m2TqWws8sCaH/aKfo176sNb7M35WtjW2Q/fsX26y2VFhxmbRas5CR0E7AQ1gWCiWihceavuwnUI88LPXz8BdEKUgYS+G6o67VUnA2fnRC1RJrYpSZTs9wL7Eg8kJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745519547; c=relaxed/simple;
	bh=PWqxGBqm0mCFstmnd0YfHIQW/zhHYQTqpo3ZPTNavlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfvjknpMxrx97pF1nx9QpExAJR+K0D+ayNlWg8lpRI3rRzTGk8R41K7eqMAmDV/sP+BEk4t+EybsKLk3nIYtUGiBkRhVY10KS+eXWGaUjo/kAe5ByLK8QLjh5L77MEmOJUyRlinpVTmLox3vpP5MX62nGvMalgUdVobio5Qj+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqcdLgoW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqcdLgoW"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22792ef6215so2693085ad.2;
        Thu, 24 Apr 2025 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745519544; x=1746124344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWqxGBqm0mCFstmnd0YfHIQW/zhHYQTqpo3ZPTNavlg=;
        b=FqcdLgoWEYnc56GsqNrTs7eH/uc/Qa8BBB6DpnFEh1oETstUTsXjG/DODsJdQYcIPc
         HJ/83N5fczaOpE8uZwrv5/8mB5RjGTPcLgFfqMTTS9zc61AFqaVL7eZd2QYixJhyUpUd
         zoRFkcd8a6jKygGsgx2P2XZaqHAxMZXvkJj6UCaJQVKuiCfWjAjKsczMLSllOrUsXy7D
         j9sUxAisBKr69QsBjaAPbWtJQQaepZv3NuHdYysN3TcDN9wg745sgS341NDGw/iBEDzG
         P4+EB9JVvtt49lawyH/vGsDlLl6tAaDv+BR84huc3GNAIJNRxOXjeA/dtu4N9svZXuVG
         AVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745519544; x=1746124344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWqxGBqm0mCFstmnd0YfHIQW/zhHYQTqpo3ZPTNavlg=;
        b=QIAlP58KiBeW+XP0ImsuxSUJTJhyefAPbtitu7W3dmTpeJi6lgADPr0jgidypWQihi
         XtLa0lNd0bBuJQl8hPRuzbGlyMapztdvyRXM5wJWRS6hgPocgLP1oHytR1YdKKkmKZHY
         y8F3IurgOalJRSXkPyhW/238aoBjSMOnZNKor38wRoQ9QIDv1NpMTgfmr1nvkoEKdWkL
         kC2fgmU6QzLwgTQjwOyG96xZ5wFQIeRGC4ncp4dxjcCwbsQwQMGGAecdZwzRQUkIYCHE
         0f2uPa/OXi37rrBT+2XSDtdApB98oxp6ttT+Q6O0q0Gc91b4QBZCoHeEjooJ/Z6sSRL0
         Tc+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3HVowxeaqmZ99gLIP/oYa+U3NrDXn9DD07ZaPWjtBK4WyXjAnPLUJxbet4foqk4w3830GOHxYtX0ybEHh9v6LnQ==@vger.kernel.org, AJvYcCXFnbDdQI1VLA6m0TlTxYT4Ry4K8wSE7NN7+DfyvON0OsFJ8O+0otSpXMuuv7QnhwsiLnZZks50x5Zp//4NN6uTE4eW@vger.kernel.org, AJvYcCXLv2Q+o0NTZ2E2EKjmFATU8/dn3VJarcGcHz6y6tFBaG1ELI4vc80CnTA3MhK+QHedtH4Yf1UZ7Hng2ebIIjor@vger.kernel.org
X-Gm-Message-State: AOJu0Yywi3gj1UseIaehn7UJStsvSYrg1pAG0cBOT1E9Zx/c+izWDGuT
	PYqkiSXsKLqpehb7Nn7FO5al0dp43+N0Y50PTDsXfBJf03QEsHB8wQykuo//8L90fvmFs/lLAMC
	bVrjmww+O2OaOs01EgOVIaDhjBtg=
X-Gm-Gg: ASbGnctn4qrirknnoMBUbWklaWqkgBLBYptpaP8oDXFfD+CUKg+ArW1S5Ly5dAG9YaW
	NP/+JQf0iIwPeeQcn8ewXbA9K9sRcKOPEAxNl8u254X5TBg5CNLh4qIVoHP8L2/TadIMQb74Jfx
	kstjDImjn8jMyUP0FPKvAU4w==
X-Google-Smtp-Source: AGHT+IHkC9ZwDM9ltxXoIZCTN6bwJ1VBYzoPMAvs9wAeWzPstnX0Yne0+vn7j6P5wRtymjuIHqUokJmcuZSEbMjh4L8=
X-Received: by 2002:a17:902:d589:b0:224:1579:b347 with SMTP id
 d9443c01a7336-22db3c31011mr20288065ad.7.1745519544529; Thu, 24 Apr 2025
 11:32:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424162529.686762589@goodmis.org> <20250424130421.53877e58@gandalf.local.home>
In-Reply-To: <20250424130421.53877e58@gandalf.local.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 24 Apr 2025 20:32:10 +0200
X-Gm-Features: ATxdqUHOhToA3p4S9cpP8XMX_ZAHvboSK1v3e9z9JkTdMKBJR5K7p4zsCrv7jgg
Message-ID: <CANiq72kG5-qZ2TopNx_AxYoB65XP7vHaNiUv4jh+w6MCrAnfbA@mail.gmail.com>
Subject: Re: [PATCH v5 00/17] perf: Deferred unwinding of user space stack traces
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, linux-toolchains@vger.kernel.org, 
	Jordan Rome <jordalgo@meta.com>, Sam James <sam@gentoo.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Jens Remus <jremus@linux.ibm.com>, 
	Florian Weimer <fweimer@redhat.com>, Andy Lutomirski <luto@kernel.org>, Weinan Liu <wnliu@google.com>, 
	Blake Jones <blakejones@google.com>, Beau Belgrave <beaub@linux.microsoft.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 7:02=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> Lovely, gmail doesn't like my email :-p

Yeah, I had a moment ago 3 of your emails in my spam, so it seems it
flagged them also for those getting it from a list.

Cheers,
Miguel
