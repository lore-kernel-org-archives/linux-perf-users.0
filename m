Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279143;
	b=VR4L0ZrIOwPuvHZtsmCCQukljuaxAlLaRoO9lygLJsSZyYUk/mKua5bWuNxlOsLpsgF8
	 t9uaRk2n928NwAHTMan/Uy8LUTkpVZdjXG/UwFl+2uPEIFLlpPfnOkZ9V+QuA7a21VUog
	 NJVjTMH1mbCXK36uX1kzrJa4vrXqAGxBtM1r/7CpqrHBZufdTkKnmFR5Ekpj2sQPSCwC5
	 gBJ23YMf0NK9ysvO1cblea0WMspTuyJxtOLO6N+1cJnkKVDGK5vrcYs9ACwgAPI/u4oja
	 gnMsSF9mSwNEhrh4/KghhKYz4Jllr9Y8GIcOJ8rQ5rGUIZNV+aJPziaAm+9p4hKptIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279143;
	h=Received:DKIM-Signature:From:To:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=dwvjrJoYeA54vumBFwN/m/2RXgd65LMFjtyN8ZCc3m0=;
	b=tYcIvAKfigSqLV8sWXBTWHcugWdAo2wG15SIq7buMEQx0vdq3YTbfg2M0k8LOdcOuBDY
	 iQLrJdmbMMejaxvwFmZjsMZ6s2TIFGivWARuTue9nNF4eLmTuDTGRZetcx6gF2BEFeEi1
	 P5n81zbMZuP4/ABOlwm+LbMOgW4CvQa+Rt4b/rvoCbCs/MM+hDJAdgop6APFztfSNDNXt
	 XJblIk+Bm9os9gkmMh5DokUe1kGsOlkWOD41ffXrcdxjrT6tHZZfBHntnOi4hUYVqj6vL
	 e4TtsAc4RuFAp0GkETAeUpH6rVYjAJkgFhSOxjKYPefjQ7aOc/M8tNCpxMQ+Z+oB2rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+hA6Xu7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809E7606A331;
	Tue, 10 Nov 2026 02:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+hA6Xu7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A151F008A4;
	Tue, 10 Nov 2026 02:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279143;
	bh=dwvjrJoYeA54vumBFwN/m/2RXgd65LMFjtyN8ZCc3m0=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=i+hA6Xu7ZOATpSVyXDyvv88h2DGJstQsx+Co48tH8ciEb4BHv/91JkRVl4sT/ZcDc
	 OdIWIwn6bkJ0rqG8g/+xZ67WE3ZP1qmt5x2UFb3ksgAsZLT3dsgNCQib6ogGrtOBIi
	 DYs0567MwLheX6ySr822CID4mljGrq697NglurMyWwYyveIAmpd6336IUapJ1jcegh
	 Ch4y3ANbw0rqblnkZ6bcWhdN9LGVx0TuACFkXA0wsnB1q4joz6/rlgM7cppcSJq2UA
	 Lj3FiF8wf0luHgg0oemZjy1ccjOLrYa434DjoZEZvxa/rUx9BC9Xtpxu7AvDMnJnm1
	 qCUxVPX+6HiWQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Alexander Antonov <alexander.antonov@linux.intel.com>, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lirongqing <lirongqing@baidu.com>
In-Reply-To: <20261106021913.2341-1-lirongqing@baidu.com>
References: <20261106021913.2341-1-lirongqing@baidu.com>
Subject: Re: [PATCH] perf iostat: Preserve the port count when growing the
 list fails
Message-Id: <179427914276.13444.7694722707324816560.b4-ty@kernel.org>
Date: Mon, 09 Nov 2026 18:52:22 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

On Fri, 06 Nov 2026 10:19:13 +0800, lirongqing wrote:

> The root port insertion helper increments nr_entries before reallocating
> its pointer array. If realloc() fails, both the scan and filter error
> paths free the list using the increased count, reading one pointer past
> the allocation. Failure of the first insertion instead dereferences a
> NULL array.
> 
> Grow the array before changing the entry count or the port index so a
> failed insertion leaves the list valid for cleanup.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

