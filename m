Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0569C433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Oct 2021 12:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B777B61263
	for <linux-perf-users@archiver.kernel.org>; Sun, 17 Oct 2021 12:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbhJQMID (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 17 Oct 2021 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbhJQMIC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 17 Oct 2021 08:08:02 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6231AC061765
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Oct 2021 05:05:53 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id g14so12542868pfm.1
        for <linux-perf-users@vger.kernel.org>; Sun, 17 Oct 2021 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YMV+GzdlocvpvMdKO0g2ndC3o57dFYn2DVsmYDcVJw4=;
        b=pRU8RRtKsWk0WpcImZG4W3fXbjiJY2nHrWDjCYI8HhsDdTrPrvrkJd/BJHBpq4BQ7H
         JXiDTmWAyA6+qKctCWn5LNlXz514PgqAgbquzygefoTA/AokpGZMgm7jAIJ3TQzzaquH
         lUFGa82/5DxGaysD0hNEUeFcWmrheYKoymwxhf7BHt7yX8c2oWxv+9mLV4mN/TSmWrMr
         ZQWpmaoPyqR85jYP87XvbiIan2sy0jk7XP6cRlQcZe4Jg0UNiLqRmBACrzQHJRkGd7eq
         Qxiq1Pvlf/8RTrMsmuCFnCDKzllp0NlGufHoYMewkYT9+BPoc0uEr0mTqDg+iNkZKE7J
         ojmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YMV+GzdlocvpvMdKO0g2ndC3o57dFYn2DVsmYDcVJw4=;
        b=5WXtGJp7CKI77+MgrwZzvuQaxgUaqLSyclETw29Xp10gD5eKS33r3Njpr9ZIEbrdyh
         jcF5Omds4pGa5ELEiWFN2WANwHgNqmjzBVmEcq7DPAonspwLb0KwYB3WdcCw/GipzXI8
         VXJ66Qyq4jj4Wm01HmZwCNLN7kjVAsrtfneL8sj94tXVQtbxCFR77bJsCT05fTXOr0MF
         dEHlRTJJvIyL+71AjBLnIdf3ZHxrtmradEkv7DXm/zJoIB01K8Tx9o2Ygu2ia5HEZT44
         4lfCS2VnXMfMWaJOjq/b23vAzJjc4z4MlfdAj9d3p5+vbuaFIpsJt2EOJgF3kXTv7K0/
         uzaw==
X-Gm-Message-State: AOAM531sQ7AaWpydg9eo5jLLr59JXUfKbqNYeVoOE+vRtIdfDyYCANQ8
        YgGn0r6xTjAXU31OKNEgv4I33A==
X-Google-Smtp-Source: ABdhPJy5Ok8KRBDEMCPZbGvK466Q9d4+Iq5MOISjnLu/GA6jIg6D/l1BrGO5u726FO00wt29zBv6kw==
X-Received: by 2002:a62:17d3:0:b0:44c:6022:9428 with SMTP id 202-20020a6217d3000000b0044c60229428mr22669719pfx.65.1634472352677;
        Sun, 17 Oct 2021 05:05:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id u3sm9998398pfl.155.2021.10.17.05.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 05:05:52 -0700 (PDT)
Date:   Sun, 17 Oct 2021 20:05:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211017120546.GB130233@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154635.1525-4-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 04:46:34PM +0100, German Gomez wrote:

[...]

> +static int arm_spe_find_snapshot(struct auxtrace_record *itr, int idx,
> +				  struct auxtrace_mmap *mm, unsigned char *data,
> +				  u64 *head, u64 *old)
> +{
> +	int err;
> +	bool wrapped;
> +	struct arm_spe_recording *ptr =
> +			container_of(itr, struct arm_spe_recording, itr);
> +
> +	/*
> +	 * Allocate memory to keep track of wrapping if this is the first
> +	 * time we deal with this *mm.
> +	 */
> +	if (idx >= ptr->wrapped_cnt) {
> +		err = arm_spe_alloc_wrapped_array(ptr, idx);
> +		if (err)
> +			return err;
> +	}
> +
> +	/*
> +	 * Check to see if *head has wrapped around.  If it hasn't only the
> +	 * amount of data between *head and *old is snapshot'ed to avoid
> +	 * bloating the perf.data file with zeros.  But as soon as *head has
> +	 * wrapped around the entire size of the AUX ring buffer it taken.
> +	 */
> +	wrapped = ptr->wrapped[idx];
> +	if (!wrapped && arm_spe_buffer_has_wrapped(data, mm->len, *head)) {
> +		wrapped = true;
> +		ptr->wrapped[idx] = true;
> +	}
> +
> +	pr_debug3("%s: mmap index %d old head %zu new head %zu size %zu\n",
> +		  __func__, idx, (size_t)*old, (size_t)*head, mm->len);
> +
> +	/*
> +	 * No wrap has occurred, we can just use *head and *old.
> +	 */
> +	if (!wrapped)
> +		return 0;
> +
> +	/*
> +	 * *head has wrapped around - adjust *head and *old to pickup the
> +	 * entire content of the AUX buffer.
> +	 */
> +	if (*head >= mm->len) {
> +		*old = *head - mm->len;
> +	} else {
> +		*head += mm->len;
> +		*old = *head - mm->len;
> +	}
> +
> +	return 0;
> +}

If run a test case (the test is pasted at the end of the reply), I
can get quite different AUX trace data with passing different wait
period before sending the first USR2 signal.

  # sh test_arm_spe_snapshot.sh 2
  Couldn't synthesize bpf events.
  stress: info: [5768] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 2.833 MB perf.data ]

  # sh test_arm_spe_snapshot.sh 10
  Couldn't synthesize bpf events.
  stress: info: [5776] dispatching hogs: 1 cpu, 0 io, 0 vm, 0 hdd
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 24.356 MB perf.data ]

The first command passes argument '2' so the test will wait for 2
seconds before send USR2 signal for snapshot, and the perf data file is
2.833 MB (so this means the Arm SPE trace data is about 2MB) for three
snapshots.  In the second command, the argument '10' means it will wait
for 10 seconds before sending the USR2 signals, and every time it records
the trace data from the full AUX buffer (8MB), at the end it gets 24MB
AUX trace data.

The issue happens in the second command, waiting for 10 seconds leads
to the *full* AUX ring buffer is filled by Arm SPE, so the function
arm_spe_buffer_has_wrapped() always return back true for this case.
Afterwards, arm_spe_find_snapshot() doesn't respect the passed old
header (from '*old') and assumes the trace data size is 'mm->len'.

To allow arm_spe_buffer_has_wrapped() to work properly, I think we
need to clean up the top 8 bytes of the AUX buffer in Arm SPE driver
when start the PMU event (please note, this change has an assumption
that is meantioned in another email that suggests to remove redundant
PERF_RECORD_AUX events so the function arm_spe_perf_aux_output_begin()
is invoked only once when start PMU event, so we can use the top 8
bytes in AUX buffer to indicate trace is wrap around or not).


diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index d44bcc29d99c..eb35f85d0efb 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -493,6 +493,16 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
        if (limit)
                limit |= BIT(SYS_PMBLIMITR_EL1_E_SHIFT);

+       /*
+        * Cleanup the top 8 bytes for snapshot mode; these 8 bytes are
+        * used to indicate if trace data is wrap around if they are not
+        * zero.
+        */
+       if (buf->snapshot) {
+               void *tail = buf->base + (buf->nr_pages << PAGE_SHIFT) - 8;
+               memset(tail, 0x0, 8);
+       }
+
        limit += (u64)buf->base;
        base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
        write_sysreg_s(base, SYS_PMBPTR_EL1);

Thanks,
Leo

---8<---

#!/bin/sh

./perf record -e arm_spe/period=148576/u -C 0 -S -m8M,8M -- taskset --cpu-list 0 stress --cpu 1 &

PERFPID=$!

echo "sleep $1 seconds" > /sys/kernel/debug/tracing/trace_marker

# Wait for perf program
sleep  $1

# Send signal to snapshot trace data
kill -USR2 $PERFPID
sleep .03
kill -USR2 $PERFPID
sleep .03
kill -USR2 $PERFPID

echo "Stop snapshot" > /sys/kernel/debug/tracing/trace_marker

kill $PERFPID
wait $PERFPID
