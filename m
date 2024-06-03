Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7CC111AD;
	Mon,  3 Jun 2024 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717403509; cv=none; b=tyE/g9hHblZOoy7EmXqNolFFhJ5b9ogkKdzpH/XjhhMqtH92fWvCVnmxgEvWjn9Rwy/KIZpVDU6s5alnM1sOGjXzIndDmK6U+LhcvbsY/4xxiWiD9RpWJz+o0ekqC3MkqBHEQcEQXFlTr3Ch/VpUM1AYYjD3g9hmw0WvlOR6fB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717403509; c=relaxed/simple;
	bh=Mq6nYuQC+dRiEYAxEHu1K3U2Fr6SaOQyUVfSC5C8K9M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXzcvto5pnPkEX0B2UV+HujDW+LbmX7T7LVELPL0nJ+PuckI06W16o4sbFuuzqPNU4hLizTv5OJYhG75yxtQWYDc9r95tzwuPOBjJyOuiJohFo9+kX7fDr5B+yZfKO10EvMcbNQNAX491nMABhIB0GwlJM3JF2i70G0wl4kCBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vt6Kc5wrlz6JBGy;
	Mon,  3 Jun 2024 16:27:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BDE8140B63;
	Mon,  3 Jun 2024 16:31:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 09:31:44 +0100
Date: Mon, 3 Jun 2024 09:31:45 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <linux@treblig.org>
CC: <yangyicong@hisilicon.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf hisi-ptt: remove unused struct 'hisi_ptt_queue'
Message-ID: <20240603093145.00001de9@Huawei.com>
In-Reply-To: <20240602000709.213116-1-linux@treblig.org>
References: <20240602000709.213116-1-linux@treblig.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun,  2 Jun 2024 01:07:09 +0100
linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'hisi_ptt_queue' has been unused since the original
> commit 5e91e57e6809 ("perf auxtrace arm64: Add support for parsing
> HiSilicon PCIe Trace packet").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
LGTM
Minimal
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
by which I mean I searched for it and indeed found only this definition.

> ---
>  tools/perf/util/hisi-ptt.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/tools/perf/util/hisi-ptt.c b/tools/perf/util/hisi-ptt.c
> index 52d0ce302ca0..37ea987017f6 100644
> --- a/tools/perf/util/hisi-ptt.c
> +++ b/tools/perf/util/hisi-ptt.c
> @@ -35,11 +35,6 @@ struct hisi_ptt {
>  	u32 pmu_type;
>  };
>  
> -struct hisi_ptt_queue {
> -	struct hisi_ptt *ptt;
> -	struct auxtrace_buffer *buffer;
> -};
> -
>  static enum hisi_ptt_pkt_type hisi_ptt_check_packet_type(unsigned char *buf)
>  {
>  	uint32_t head = *(uint32_t *)buf;

