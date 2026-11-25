Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625147;
	b=bNLyDdj0zfSm/m3sfxDC7JQgnUqL09VSwV38OH8a0b1OP1weEeLOAkwGGtNOZ0dEdzY+
	 h6O7KJoWGOkG9piGTupFMf9bVg9e0A5mpu+lgshF4zdBP58CGvSzOvS6VZbu3askbhrg9
	 ywFdq3VetcFvnGLhdiJHh6gzDYhXpdRBm79tIBVOO50eDNO3bXU9p7kbveodMH/f4nftk
	 q/j6PH0gtV/fPqappEu0XtD7Ds/+XQb6twz+knQmG0xxAkKsKI/ryA4yMWpLpunYn8ucM
	 BkQCPUNZ3OaEvEEurhlxIrfyNJn3IvLXL7zQneqzzMDc8i7DwSElwRKS4zMn5LNYz+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625147;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=kX6olOzBq41GkfDHyUGpCY/uJoANcms9e6hEsvxBREI=;
	b=EN1Hyxa2/OiuNsAr0pgr6Wq56xZV1yknPSj2HCooX50OGR2vxvUkkQRxBLeLTu7SrGUG
	 24DJoG1Z5nW86e0GJx1YBmXiraIt3sJT3RLB1kjPOl/WR/km8SeKLB+VtSEGTcAAYPmOB
	 AmUSc0Xk8rFokT/FeFXNkaY82PORaKqn7RFl+YmsDwEp18p7Dv6JDXMvO21Dd7pkaGYb3
	 9lNHSYjwx54u1HiiBsnQDDFwjex1moJeCo3amtfNjVMU9+gNmrCGM4Pxwrc7uz9ZCo14Y
	 iRTy5bdrKPgLnDWTW62n7QJIeua3zOFCOT+VZZ3Nrs3zYQi2NZrrwM18of+RG4P2VDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=P8DOkGGG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=HDI9Sw0z;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07139606A6AE;
	Wed, 25 Nov 2026 16:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07139606A6AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=P8DOkGGG;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=HDI9Sw0z
Date: Wed, 25 Nov 2026 17:45:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795625145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kX6olOzBq41GkfDHyUGpCY/uJoANcms9e6hEsvxBREI=;
	b=P8DOkGGGGECMk6DEE17kITZt6KDpur38Pi8WmUtQpyNUsv/w40jlZmWkFr+fFamfcM9OKp
	y056Rq7yebqrzaQqPK/UJ478nFY0NJBT3pAN54uB8UiMTNP7ru8WwMuCETFsfYi6zDgQu0
	4mzD0AWHJBpQxADJGo7OYeD/x+89alAw6aku8YTai7Z7k9K7vYor0eA1eJLHxPkG5iql7a
	kgptz1fdTODO9U1+jJ4cLlTlIfUmmEgLNAGucg6i7T9s7rI0g5+f272NrDK8ZQvdpycxxi
	ixnt/SfIHQxP1/l0jfa9v0KGQH8lpruot4ZWqlf2XzvP6P+7l4FaRAEWrwGPgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795625145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kX6olOzBq41GkfDHyUGpCY/uJoANcms9e6hEsvxBREI=;
	b=HDI9Sw0zpwuN8DdSW4qFUd57mhC+/OEaApcIYXkjOfS00tCyzPI6BRKQiz5Y6r78Lgiy7z
	HylbFs3NJWMK/zDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tengda Wu <wutengda@huaweicloud.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] perf/core: Prevent duplicate sigtrap task work
 enqueue
Message-ID: <20261125164544.OQOQJ1oq@linutronix.de>
References: <20261120154457.GZ2668564@noisy.programming.kicks-ass.net>
 <20261120154959.zw08JC0V@linutronix.de>
 <20261120160140.GR2668804@noisy.programming.kicks-ass.net>
 <20261120162604.GL2669272@noisy.programming.kicks-ass.net>
 <20261120172831.5XwELZY5@linutronix.de>
 <20261120174942.GU2668804@noisy.programming.kicks-ass.net>
 <20261123080004.MKzgHQ3W@linutronix.de>
 <20261125082711.GV2668804@noisy.programming.kicks-ass.net>
 <20261125105547.WBO5iSOJ@linutronix.de>
 <20261125161735.GG2668804@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20261125161735.GG2668804@noisy.programming.kicks-ass.net>

On 2026-11-25 17:17:35 [+0100], Peter Zijlstra wrote:
> Ah, indeed. Let me add that as a comment.

Perfect, thank you. I would offer tag but since you did all the work
yourself, I go stand in the corner=E2=80=A6

Sebastian
