Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096107;
	b=gr9wNtRpynmGQfQDSDXRFm4SWNLfRRrMeIyQYtz0zq2geRgvbPldVNSEukp5vFjmPNHM
	 5s2b5/ZKObVoUs+nllQwgIkevvWB3pkZEW12FaEoA42BvygLbRbOkQpMwRX8Hy0HwTdko
	 mocx7+5TfF7QtmF5kqLSmBW/R3U8ysBQAiYM2XBSstSBV19u9tmalvRADWlx2/OUdAIeH
	 A2rjex035eNk+bNUBFrtadOWMt0c/wwzomdOx6ei5Imvhz6AP/GhFXNZOrvT1X0Ei+mCM
	 bCQ0SfsUbgiWlLM/lHKi901rYTjxksWJqRhWOE0zgWa2CxBuCgOSYP3o0EcAQSr/9Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096107;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=cFsSr4rFLD0sZgWO3UICEWG59/9WjZ3zDUquQvzWPo8=;
	b=KlqUx2p8B0p8xWUffL4u5YW/ETRQhLYaWZdacJe/yo2S8Yj4IchNXGn6p9iqfaS+rpGw
	 AcWUg9VuknDjjvaF760+oYR2HRy5R5ec+9t2AJruZrDpSpSwZstGrvSr6Zw/ZN1t3QVnJ
	 VfpaodqfRfLdfQRNeFY79ZzovXdl+prwzPIKNcYPdXvS6RAVK3iEkOYCLfJztY0bAP6uK
	 QISk3yZCtzFr3mr4SzX3mrAcpBgB+AdhNUF8NCuNsOUysfEvlZeLaYb6uu9v8R0Kw0as2
	 aPehfwbW9KS15A1IBoANTSvHtC1FMGoSpqVbUPS+S4j9IymATgGSlDaSUM8jMq4diyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=WGCEgd8y;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tjanXcst;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C737606A325;
	Thu, 19 Nov 2026 13:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C737606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=WGCEgd8y;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=tjanXcst
Date: Thu, 19 Nov 2026 14:48:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795096105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFsSr4rFLD0sZgWO3UICEWG59/9WjZ3zDUquQvzWPo8=;
	b=WGCEgd8y32aniz5UgOEt8zIgfc6raHwXSRhbOwOIT7NBEvPBXuJScS4nii8dKUCldsdna+
	dPmLGetDhjvt4L7Cm2QIPJQW4EtVT83PCKXTPtgw3yH9dqKRdCpR0AdsTTc3nY6/VngH0o
	Mu1WzLoBLzhqJOhg9O2g1VipnQ0HFXx+L9tuIieGO0d1XQXWieeMsSspN9qpAihl3+h5Lq
	lIYIZF+oj2Y8ocvUJTKYDOzV3pgPSzXz8zKoDPgUVAIx3k+ml7ULt/R0xBkrp2wbD2Ahio
	41LgrwT0XegaYl1vmMzT02lSe1vkZMqa2hCn7rjvnX7TBHjVoIMDt3L0yFurQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795096105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cFsSr4rFLD0sZgWO3UICEWG59/9WjZ3zDUquQvzWPo8=;
	b=tjanXcstGZ9CVzp4RvSx3wr4tqD8vrHFqhaAhAcaMyYUUruS+FXey6bgYFszGmrlItUH1V
	oEo3YqKMhwMLbYBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Message-ID: <20261119134824.oCI80nCj@linutronix.de>
References: <cover.1795053619.git.wutengda@huaweicloud.com>
 <55b1a2845b0ad34a874a7653644e34af9eb068d3.1795053619.git.wutengda@huaweicloud.com>
 <20261119121143.pJrJE7qs@linutronix.de>
 <cc76ea5a-545a-4560-a039-ceed1de7ff3e@huaweicloud.com>
 <20261119130704.A5iZtay-@linutronix.de>
 <0aa4bf03-57a8-48d8-b8db-4246716c48fc@huaweicloud.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <0aa4bf03-57a8-48d8-b8db-4246716c48fc@huaweicloud.com>

On 2026-11-19 21:19:59 [+0800], Tengda Wu wrote:
> Well, because the trigger window is very short, it is not easy to reprodu=
ce.
> The test case I provided above must be stress-tested through multiple
> rounds of a while loop. Is it inappropriate to put this kind of test,
> which requires a while loop and has a certain degree of randomness, into
> deterministic test cases like sigtrap_threads.c?

Then maybe not. I would have to run it myself to be able to judge it.
However this thread has a reference to the test case should someone need
it in a few years=E2=80=A6

> Thanks,
> Tengda

Sebastian
