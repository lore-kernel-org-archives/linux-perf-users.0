Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793870578;
	b=hfBAtwXwXltMmTODO3Au9jYlSTpCzfPrq/Y24KOnZdBacS9lmkEeJtEStWjUBXLxBAGH
	 TgUfukmji5fOVhjyGWGYUxVaQuD7iRNQ6V56N2FzS4a4AaL+8IvaGH5ojBYGMx+WlclN1
	 jm3T+qTPFNKykYHDBHKZezeapRx6UuM6MqN/y3ZjgwD5oZPIo3v2ScFmOiKaHBZtVAzs5
	 HegLGBE1buzvAVTH7q8ZSi0W6ZzNdqWLeH6MVutvfMllei7n321RFzagcDkUYiUnoKACr
	 zgKEEesCTAnwni9EW7SziWS2PIg130k122e4eluJDcLhkYaHqNZBRPkL9CP52pZXzLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793870578;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3ADmQIxAo8HDM9v3jLMAtpR5tdAcgtAcz2GrlhHdH0M=;
	b=EgvkeljpdyPqftFrV0EJs+Q9gs8P9KmjRETc74hY+JhJ2dQ3OKteOYucSFj2WsvxWlc+
	 DfLvTFXl67/jzH8cnLwHY1u5zgBUtFXHoIi9YFMVn/zFlGSFC8QGpoETsjUdWbTBhwRTv
	 IjB9Vd57fIXeJrQIbCTkABrdCi2pzWWiYuTmw3w9ezEriSzDfoXMWai9NEtZxyMv3CtcA
	 kpGJp1jF2s3cF/2YNbm1sOGG0E/cSksbs3BBxIVjHiFJ5Q2sUpKt4tqUVBi+m+1wyjpl/
	 sGjSzN8vGqy+kxgCejXuj9UCoQmqiOSo/U7V4kg2E0Nls0d/C2PAIgPuy7cxk6m9zsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WjVvJR2t;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EB8606D813;
	Thu,  5 Nov 2026 09:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7EB8606D813
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=WjVvJR2t
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C866E19F6;
	Thu,  5 Nov 2026 01:22:52 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D05D3F628;
	Thu,  5 Nov 2026 01:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793870575; bh=3ADmQIxAo8HDM9v3jLMAtpR5tdAcgtAcz2GrlhHdH0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WjVvJR2tAoFJSufvpND4tfqyE+S7lXAB15rdV43IYRwoa05K89GDHf2rs4DM15kCe
	 eK6nxhLWcUYRKamtKzGFDQHr8ywB/C86Ioujk6V61bYHa93TFkNhVnnrL6U+V9o6h9
	 00JeJ1XMwFX1sgh7mCiAKJNbQSmjj95+kxrw+MR0=
Date: Thu, 5 Nov 2026 09:22:53 +0000
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
	linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org, John Garry <john.garry@linux.dev>
Subject: Re: [PATCH v3 15/18] perf auxtrace: cs-etm: Capture wrapped snapshots
Message-ID: <20261105092253.GO9176@e132581.arm.com>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-15-dbcb0c281b9b@linaro.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-james-cs-unformatted-per-thread-fix-v3-15-dbcb0c281b9b@linaro.org>

On Mon, Nov 02, 2026 at 12:15:29PM +0000, James Clark wrote:

> Add auxtrace_record__monotonic_find_snapshot() and use it for Coresight.
> A monotonic head can't be auto-detected in the default find_snapshot()
> by checking if head > buffer size, because before the first wrap a
> monotonic head looks the same as a wrapped one. The search would then
> falsely detect a wrap when head is near the end of the buffer, and the
> wrapped pointer fixup moves 'old' and 'head' a whole buffer ahead of the
> driver's head. With a wrapped head that doesn't matter because only the
> offset within the buffer is used, but with a monotonic head the next
> snapshot would either save already saved data again or drop up to a
> buffer's worth of new data.

As mentioned, the default find_snapshot() can falsely report a wrap,
which now prevents us from using it for the monotonic-head case.
However, I don't think this block consolidation; I see the decision
not to consolidate as a design preference.

If an AUX driver transitions from an arbitrary head to a monotonic head
in the future, we might still need to consolidate the find_snapshot()
implementations.

Reviewed-by: Leo Yan <leo.yan@arm.com>
