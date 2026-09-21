Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390794F68C7
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790014587; cv=pass; b=hDEKbiLhRdFxU5pv3V6x1Y3xeMnrBpWSPStWHnw7HD1LOuZOoDNamc+bDflSDT6ebxu1tF52LEa0zE+OMx6XhQKLAOnpNZ/I4k2CP2LIWcPwVFQahK5MpU3AOHrBqHQErSKQoNrMflWLce6SvR+N+NyAZ3fiqKr4PPmfymRewqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790014587; c=relaxed/simple;
	bh=BbpR1PLNc0jlsGbwUI8mzvAgF+2/fHU8K6V+IvKzcdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyKLqWurr4pNpFe+csBEI/le1A4hf2K7J7TMNEWuVxe4DVxY6157iHU+o9Fk3pQlbdU6xY87D1YRsgtkxoTBZBvQDatxbcwevNlafeRwePz4UbWV4q1FzCigl5v7Am4WJ+NQEwGyzYMNB1Ker+xsO6S0LzS/izn1fBoQtrTJTok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+l/ZK3U; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+l/ZK3U"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-530e8c6fb80so25691cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 11:16:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790014585; cv=none;
        d=google.com; s=arc-20260327;
        b=lBdcBphf9cLg4H44xzeh6XL/pufoZRcxjFNBkw5Q47mH/IQh10hz9PctfDz0mDXU+T
         6GyyI4qQjN7iytNSHBLHXWe1+QkTy80CVR7Ld5otQnfyrNTga01kGe1anXZKV7mFID+9
         Ce0ZvrAVbJ4mL7DpZ+gJaI0t9vTFEqo8BrEBm6kuiMzrODqjx6UO6erz/KajeDw+Kbqb
         AQqi2Qet6wHoFeZvU0O8+YocCNL7MkjCr83Y0m67Z0XUZuqOvw9cqqefFHE7+vPnhhQm
         QzSP2F8XO3odLkaerz6JQT3swnhgHnantwNrCc7eq/Wvo6rbtgeBLAMoS+GMe6YtkTGq
         GkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BbpR1PLNc0jlsGbwUI8mzvAgF+2/fHU8K6V+IvKzcdg=;
        fh=yJDzIZIF5WfUPUQdyxrgXpzXUXcE29U/y2ULJL9hFPw=;
        b=lb3R7JPOiDEh70yt5ajzwVTGoTPEojHEGcPiwDrqf+VzxxF4MEt2rh3u1t2klWSG85
         5E+PaKBVPj6jcVwSVfDEc+Izqd1Wp26RZNCFvo9DUKoWDdCWRoTDENDUX6YfpHmH4Cqz
         eq0sX6L6biLbGIUmFk3KX1deulFj5ijl+h6kL8irM2o/0z5iHf3yruifimMKdmeYqtRx
         j5c/U6N+TUGuwtBu821JTyEA+oNgBEI4x1V2BDEOPnr80AYQnWBZxOu4e016RU1E0PC+
         iqPcph3dDEp8U5gKd8ul3xzZjNQtLT+890/mq8xo1yFrYfMCuwbwvEolN2/DOs95yANM
         pSWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790014585; x=1790619385; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BbpR1PLNc0jlsGbwUI8mzvAgF+2/fHU8K6V+IvKzcdg=;
        b=m+l/ZK3Uf2Ubk+OlBndY457og/QLlXc8u1y4jQ2GpZfQbcrwX0UG9B+imcFnsybxj5
         leR6R2S/AC31/HisMn6iIkob/zXAdGc/r77QJI6YObuTr6L/rNizLVQwQWqeow8di30q
         HwDFh/5/tW4UFEstBJoRZDsh9wP2dlk/lnm7scelfh3BFIcTj36ZEssbiaPaSNyMmPum
         lqo8TQUyyp2VcrXmkKEwVGkNfraS77lhCAiXlxW6G9j5iU1cX0rpB1uOWawqcwv34CoE
         McID+L0Rwit1biDqE4uUUoy5EPHdVrhGQvZxHuV8bNEewM7jGGsguu3FSskBrgevRboa
         Chug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790014585; x=1790619385;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BbpR1PLNc0jlsGbwUI8mzvAgF+2/fHU8K6V+IvKzcdg=;
        b=ZDmiB6Bisef92Zndihb01+dUdQR38SjI0MVaN7j3EpqYOitLIknADE5khEEJNJfHad
         HE8TuvfPQET8etMuzjqMfgBvUOxCnd1Vn1pPevnmToUWuAmoqrGSTubm4t/i8RNv4mYw
         xgsN0LtN4Kdwd1y/P/fjFGE2H97X7UwyyVAuviA3h7AyGV0MdbCdoPUIVXYbtc0Mziuw
         Ho+fH4WEcPkc8vE1WP29FFUINPyCO6jWgwjdB7o4UZjGS7kCKDJWRzP5cA0/5ekD0p4J
         Q/3opUtiCaeQHbaVZUyFlMTQ/svvJIJTdVE50OMlV4oNMDar1vRVLVwdPsTfCwUjf3rJ
         GoSw==
X-Forwarded-Encrypted: i=1; AKwUvBzefCcnBz0v97QZuJ5Cr5ClQw3Es5UEf+hXkDfA3H2hX54H8wVNswjJ2llJlSXaLM0gBdvYvRfwpq1M4REogA0n@vger.kernel.org
X-Gm-Message-State: AFuF++kVmJmDR+AsNpyyBEUUbXnnYF14N65iazriJYfO/o2h7fIgF8kT
	gyIzkfXHXQGwlfk1EO6q2dEIwM6vtOwCK9lm1zQ0JQyVVqzZXEfAYkv3BPSjWQKsIDtKlDLDypQ
	hPYp0LwfQH1usVWr4ZlJC/SP6c4vFQRw1jXn1HAEO
X-Gm-Gg: AYBFou0DOsRoivrcKkYXlTnznCFihddRQaOuQ5wl0h24sm870bIkI74uNBcjv8JZv8J
	WDWBL8MO0DoF2feApG6mVzAidaJ7PgRlT/E2m0BE8e2sPuTty+yU0XFHsNwX60y3WPsRDfGIt9w
	1KffdcTI0X12/tNMRoRDfi2mjVpRNpB4Li2HZ0ej6qyFdXylto2kIGuy2Iz2a9JU+7iJDwUdUcq
	JKeJSdpSntCLqtFNrQUJt20AQf4izJWcwxf4Tr6y7We+jD+NOh3zX1sh8Hy8oHN9GV19NhfL0I4
	CMOflI7uA66B1nlWrtKlFQoDsfn963bjl78U/4WaXd6movWeHK5kY2y5lqPZ9oJ3qBGl3B8mlZd
	3Lblu2ptN
X-Received: by 2002:a05:622a:81:b0:532:84d3:abb with SMTP id
 d75a77b69052e-532dc3f65e2mr976631cf.7.1790014584401; Mon, 21 Sep 2026
 11:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-perf-gtk2-v8-0-e90d5d155f0d@gmail.com>
 <aqE_QOp-x1aOQsCX@x2> <aqFCMfb94Cdumemm@x2> <aqFDLQ5Yu7yg6Y2Z@x2>
 <aqFEdSZ40HkvipUr@x2> <aqFGVejYb-kZ8o_I@x2> <aqFIkFzVvCQqnzpy@x2> <aqG7c7RkOoaxMo1w@x2>
In-Reply-To: <aqG7c7RkOoaxMo1w@x2>
From: Ian Rogers <irogers@google.com>
Date: Mon, 21 Sep 2026 11:16:12 -0700
X-Gm-Features: AcwNN1UN_lh_zwfA58A54BWF4igCNKeINGJCFDqxOaVdSwz-6QzX_L2a05Esh1Q
Message-ID: <CAP-5=fV6+mzN3Lf_mCAJ4aP42JFZsF55ekvt8XrX505xOWwrmA@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] perf tools: port UI from GTK2 to GTK4
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Matt Turner <mattst88@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It looks like tools/perf/Makefile.perf is missing something in the
clean target to remove libperf-gtk.so.

Thanks,
Ian
