Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A58322B83;
	Tue,  3 Mar 2026 20:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569135; cv=none; b=Bx3OwKP9grBOgis/hcz5WIVpFdzjky+UPkXhGbc+6Q5qGoH7CY+uLlSGDTSx0emVLEo5bxVV9Nwy96ZKxwW5FpC1oA1kN9kypT7QH2aljpWkMHay34KNzk4UTk6bsuVx3kZm6lYZCXVB5q8A/Zu4uYOuB+G6a14bEq/AFsRMlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569135; c=relaxed/simple;
	bh=svODppJ4ClX3P/l5pA4WBEU85FrEGk783f1wKeE8bew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2dUpid1hHUMCqRekZIhc3V/ev9rFIa3QrxmCLMOKLOZQ6DR5fLa04hn6HMAjo8FstU6f7NAK85SLxiQpMBvGmEvtwgwkyIhqC6YUSTMy1S3WIkIaJ8X4dwvhKUDPB14Jtn58uSMl+cX9++Wl9jj3SUsxJTr4nCZXRSNQ/2mm+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlg5jbte; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlg5jbte"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EFBCC116C6;
	Tue,  3 Mar 2026 20:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772569135;
	bh=svODppJ4ClX3P/l5pA4WBEU85FrEGk783f1wKeE8bew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mlg5jbteM01C39bfcPLFFC7/53Fg9GU+beQDcWsYWap0v33VKxf7WkNtYaFUQ1CD/
	 VrfxEWw0eoD2KHCqlGI2fbwnFGDfWefPzvazkMs+CnhpRAgmX2XJhUhUa0BR7RLu98
	 hzkwEJQ2ouMqyQIXp+lcaGmP7kjdDcEI22c5ZiUv/IYGpl3xs8CuIsqJYc0fPjOvHz
	 ixqLu075buWKu1JT7efVQFwhEtNLJrBxAYjkjtgp99ioqLypBuDgLkm04qw7JXCZIa
	 jsKaozzbDYyLJxZZFOhj2xjOBCwWutyN2uZOKrZWgYwMltvmnJS+jnFTFdUqQmLCKS
	 WXI2rEx1O85lA==
Date: Tue, 3 Mar 2026 17:18:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	GuoHan Zhao <zhaoguohan@kylinos.cn>,
	Colin Ian King <colin.i.king@gmail.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf pmu: Replace starts_with with strstarts
Message-ID: <aadCK5hyArbUvYpI@x1>
References: <20260303185216.897944-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303185216.897944-1-irogers@google.com>

On Tue, Mar 03, 2026 at 10:52:16AM -0800, Ian Rogers wrote:
> linux/string.h provides strstarts that matches the starts_with
> function. For style and consistency reasons remove the starts_with
> functions and use strstarts.

Nice cleanup:

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>

- Arnaldo
