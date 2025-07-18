Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF91E98F3;
	Fri, 18 Jul 2025 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752866012; cv=none; b=T1gNCAXtXu6FEHcEwrYnjZM5e43ytDnHdYoRpH6UiBOk24MEYpXS/+AjT9af/nQ1pXZdweme+Fa+gt5hn70ApC2hoR7mWpT7gJtVEgHjFElIQgUn3VXsoJQ5x/qYp1/jGIpnHBYcYxfGbMYcBYuHHqrHJFThgiGzsU6svfadrgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752866012; c=relaxed/simple;
	bh=8NypKIe1ZZsOHejG6zGdh7arcs7UZgBckNhF67Rughc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=IE8XjuwWxMHkWmyMLQwibi5tZSPo8tqlCaZlZbuR8UOUPkRxY+51cEZbqRS4IgZuYurKfSmlhFnFLXt8n0BiMNZ4UWvU4rvLGaQ1r+T/CvgbOMOyHkVLcFND2fm+BeIHYLeC7ESk6WI3YNskp4/2eSBY4bnZzNwOQDB1MKOnF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LiNHhk9Q; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LiNHhk9Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752866007; x=1753470807; i=markus.elfring@web.de;
	bh=8NypKIe1ZZsOHejG6zGdh7arcs7UZgBckNhF67Rughc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LiNHhk9QRbD8YPiaUEGigur6nqMiT7xinnhd/26bQhnk+z09I+p3cf5oWKueoPL+
	 NZFuepobUkfDKCPvkb4zzXFCyntq3KpxEwMm/blWbQ5lRj73QNVRzKP5InilzjCtA
	 DwSpQdIPPKi/yScGh/2oGGU7d9oIlEM25DS2RjtR3P3H2CKvHNrpBSTusKwZB2R8m
	 HkcvB/JLfwT/belLNGtZQU+X2ftkSJ8Gg1W96vHdNDE7bXjykS3ZZbk0CSdfxD/S9
	 6yMef+OR3OFo3cu7oONhhkdN3QOJSlTqYiic5KligHlXMGpDuzHL1QoxF60+cj9mx
	 b8o41OWKW0Jq9b3Vjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.219]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N0Zo6-1ur3Pn0TUS-015D6M; Fri, 18
 Jul 2025 21:13:27 +0200
Message-ID: <f39dda96-9e4e-4f33-a4fb-a97c375d281e@web.de>
Date: Fri, 18 Jul 2025 21:13:23 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ian Rogers <irogers@google.com>, linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Ingo Molnar <mingo@redhat.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Weilin Wang <weilin.wang@intel.com>
References: <20250718071734.1444891-1-irogers@google.com>
Subject: Re: [PATCH 1/2] perf topdown: Use attribute to see an event is a
 topdown metic or slots
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250718071734.1444891-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vJmCh5W/B/9WFlaEkWvj5dkUe9NWWAI4JzEb8b7HrH9+Mx3CKKX
 QzaexJY8odHrtajkfOdYWnziQgkPFLexs7Smj3u40mGpi9kkVXPm6B0Z1F7gp+Jp4PruDXd
 UziZz/2gEDOt/2sizfl9xBwQAGw+ce7naz4nB0Zzo3Rzd2/Ob8G1n71ujn/saGaQTnlWr7+
 wCR9F1LrWs0D3cGHok8RQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HZeA++rzKgU=;h5xhBcQwNLBOz6ulATm464UBw70
 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
 FnoN8=

> The string comparisons were overly broad and could fire for the
> incorrect PMU and events. Switch to using the config in the attribute
=E2=80=A6

How do you think about to refer to a =E2=80=9Cmetric=E2=80=9D in the summa=
ry phrase?


Will a cover letter become helpful for such a patch series?

Regards,
Markus
