Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4E1227E8F;
	Tue, 24 Jun 2025 05:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750744274; cv=none; b=qhC0dzA4VbAJ8nF4PVY/vpV2iwBDTqHgQw9OFQsp7lbpvUNqXAnQ3jUTGmGT+gVJrD+6yO3ZAgj7Pp4PKiSkzbjf6RK9U8N/0H9aLA4QrsiGeE5lQez9qNFZ9pLYdfC1X/XDsyE+DWk98BC07KB+uzRudpndUt9pkS39xR3Go84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750744274; c=relaxed/simple;
	bh=WMTijQAae3Cvy5yZBqL+JYFI6rh9BwOtd+GPbl738/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6TFyFoC6sqf45gBH4ljn6RQSXc04ZomAKUv/IZrOGIJOWW99kgHe06AaRQ2HQQYSwUcvU21b3fFJwOCuNgMeb4Fd8DklGAdOHpDQz+kb7GwHDbpw8mVKz0QsGQtJGJx+/CG+r3nRcm60UTCvuNNVziXhSGe/H99m4JYaHICSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExtCc/I0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExtCc/I0"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-748ece799bdso3446511b3a.1;
        Mon, 23 Jun 2025 22:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750744272; x=1751349072; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMTijQAae3Cvy5yZBqL+JYFI6rh9BwOtd+GPbl738/I=;
        b=ExtCc/I0oUC/YHfbrbBDL2n5MdmL+jEQGJTjwpJyz/4sQwroknNoUmZEe15iSSRiWM
         0oRPvU2MvuVtYbIYaiAnxxQLHm8ZDiG2YsNsXoJB3cwb2KzEcOHPPhkOx5WvtJgf8i7h
         8eZuKJ/AhMCSMS6jD3OFXA84y4fMjrVefPeeaYYMs6cvqGZ/FW/FDmUZ6gMPQEzKuXcW
         KbWR1JqPgQTWByp/Qdftqp8xQjN5McuRo0XY7sg5wePybOBS05bY8YMqg5KVaL/LbjJU
         HuQ8Me8949inBEN8vEw+KWeQynTg/I905WZ3tcbcN1gc3CNyWaDV+HXgkugt3I6CqP/t
         kVfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750744272; x=1751349072;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMTijQAae3Cvy5yZBqL+JYFI6rh9BwOtd+GPbl738/I=;
        b=r72Vzo8dBcJQ8WrGZ9f7pPK3dJNM1fITaF8nOjEuUSyUvk9KzHLQhjdiBegRdLdk60
         Zp5ZE2RRJWLp5vM62K5ynp9IfF+Yo4BrPlSyZwdIPI9RUESFBxXGWp+pyBgs7dUMlsGW
         NPFq8sNpk4c5PEoK2CiXTD0LjhrwuytleLVTUj+r00LpP1eU5r4vJ1ZCY4iO+nFGdQxq
         zSJ2MpwV2l03SLqNO0ZgwUD012JhyWddlkF+Hn8Lir1sGnayUuicO0x6AxbZRZMpTbbZ
         dsRV4hQwKlz3VHGDZVeH3dEYXFi5OZyxJeFU48WoaMgpMRD9AJW7J61rIYzOD5Rw2vJP
         IySg==
X-Forwarded-Encrypted: i=1; AJvYcCWLFp9f5zzBncShJQTTDzCjpVtfdxOGWvVWGjv6VZUYWBmxicwg/SwxBl3SUn4zxmeRv3nQfTKSD/eLFj+jqMB/gg==@vger.kernel.org, AJvYcCX8OzjeqFf0T+anAFNh2aN80Pa16q6I4VEKL2lWiDQCQLvHMHtYN/7iEL2JFy2XsY/wqDI2T5WAYo8aNwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa7ErQoXMhGLeEAFyA5YGPugthyJGLhSarJG1X0XGruesyUOt1
	4oUMTjNEbEXE9DSCM/sIFLxaLPaAkBkVqSV8etCggmWn8tL7f8ycElfxjifkI2ji
X-Gm-Gg: ASbGncswPYETpXeh2sU26pc1sKfNjUYUlksgkqQlYecuhU2ANayfrldBkzHudc6Akog
	NPW/4nIiv6yoB4qkGJ64Vd6vVo5QpepUc9oPrTJDuz7TBasJSYeAKpf5Uo6mj0qoctNqeTOlimI
	VE+KCP7vFG5JyhOoyVa0A/bI217VcDFGL1BIeHQ3Pt33ebBx15vLNhkjwINK6ZQGNVAfm7K5bAG
	PbyPzM8iU+8V8f98LbeHWOrX2TV/mwLgl+gOa+CmUUGaM5cjjefwG+yTruLIah6rLjuscfZdJa7
	bWS1wTIQsfun67+Qp/JqkfNJP8VYsiJHVCwOFimfy6U=
X-Google-Smtp-Source: AGHT+IH0XZ2WDT3LuHvTghiC2fj4zMBnklK+DT7oITx1WandTGGQ89EgxL9ZIllkHWZZgC1ZZ7GMbw==
X-Received: by 2002:a05:6a00:1954:b0:748:e0ee:dcff with SMTP id d2e1a72fcca58-7490d760679mr21088813b3a.11.1750744271584;
        Mon, 23 Jun 2025 22:51:11 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::1707])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-749b5e2145bsm941760b3a.54.2025.06.23.22.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 22:51:11 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Namhyung Kim
 <namhyung@kernel.org>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,
  Adrian Hunter <adrian.hunter@intel.com>,  "Liang, Kan"
 <kan.liang@linux.intel.com>,  James Clark <james.clark@linaro.org>,
  Charlie Jenkins <charlie@rivosinc.com>,  Ravi Bangoria
 <ravi.bangoria@amd.com>,  "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] [PATCH] perf build: Specify that shellcheck should
 use the bash dialect.
In-Reply-To: <CAP-5=fW6oMGcGcBgxVWOrkxcPRo1EDVAHe4m0F-ratRkpKjL0w@mail.gmail.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
	<f7ea3a430dc2bd77656c50f93283547d1245e2fe.1750730589.git.collin.funk1@gmail.com>
	<CAP-5=fW6oMGcGcBgxVWOrkxcPRo1EDVAHe4m0F-ratRkpKjL0w@mail.gmail.com>
Date: Mon, 23 Jun 2025 22:51:09 -0700
Message-ID: <87ldphit6a.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ian Rogers <irogers@google.com> writes:

> Could we also place the "-a -S warning" warning here too?
>
> Thanks,
> Ian

Sure, done in V3 here [1].

Collin

[1] https://lore.kernel.org/linux-perf-users/f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com/T/#u
