Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EC1B0435
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Feb 2025 06:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739860094; cv=none; b=UUDxxwbRm3ZZD0P9pp3I+s8JcO+Hw62ooWlyxSSuP1hSThXgKyFbGvvepVYDRbQeb+OYrOmSNlXwYgK0wtIN8xNFXLjkjf9f1FwLUpBU4r9L6zUCvG//BXre6Vade626j2niCabKa6Ig67eXU2vEfQ5vMszXoM3BUMgKfBelFd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739860094; c=relaxed/simple;
	bh=F8tO1I7sgq6bEUz3LQeyt2n1wCJx3tAujTQmrGimQNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utAzjmguqj2vHPDwCSSJm6ZNjvR6lohTYTO/r6ZcCblimngpCny+g57+OSmV2p/G2VNLAjKQzK/TJnb/qNKdmwl8EZf2p0msCdFThRJ3EqYU/pgXisOydlQOA0PnErMltTvfhnEOd+CYxcvbS+8+CcmF3HzoLdEqLGtTINC9Yng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VAV15OkT; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VAV15OkT"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3061513d353so54020831fa.2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Feb 2025 22:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739860091; x=1740464891; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F8tO1I7sgq6bEUz3LQeyt2n1wCJx3tAujTQmrGimQNk=;
        b=VAV15OkTuqDlh6L9qQiS4YSeRB7001GkZnMBHP13fc3cW7/Qo5N/7YW1dNIWkfvgC1
         977VaCXAMqnvwBoTCE+0khaPyFm0Ko3ISyAHTCCbVu02AoIFPwZC/82qRfGaWI1zHB8K
         LxWkkfzoHp36Py0W283Ka/IYuKTDUvV+ratgYYsH0T99LZIas7+DiWxEGGAP3l4WFZpd
         JJIx7ai0+olmGt2wo8hT3V6lmm985CbOwjOisn/sBIfX9JT/SF9ho4EpdF4n4jyI1FVD
         nxAw0qZIJiq0nFMh9tUwk7LkOwz1Erh8rdyBY8tluUNjbvfkq67KUfBqtPBVnP1s8kJE
         ddsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739860091; x=1740464891;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F8tO1I7sgq6bEUz3LQeyt2n1wCJx3tAujTQmrGimQNk=;
        b=IR1Qa3FRLugpeqNH5pavLzrWsFFv4kTsoSeezq7oMltay3yBeDcj2GPORkuGkdltLS
         xQeRZdAzSugsi9JBk6rtFagDznOHbkSHtoCPkITqQSQr1XsQtjWHSrmnxGTbnxFYeCEy
         NUztGWmbawNx2DREm9K8byPMGV0ysUzodHaocY7DON0J4jjUx/5OtyYzHQhLfW4eDK76
         NsspswYrTnOTbKlE0yN1zxuHWTcGqs7B5K7tyYKZN6BzpFELEi06ExfCUa1dEEKijvbg
         b6qyDgpwNpRtDrM77zaWG24Id6p/ehHPps7G804U71SAVuE7t7bUjpvikGNCIsDgW8X6
         BGmw==
X-Forwarded-Encrypted: i=1; AJvYcCVykwRVRy7HgfFQLDjhUqRn5EIQ07UrkxZ+lvU7LILOibHcfz2CaiPCwxrE3Se5fhXgOPaDgEl8kG00Qcd5A63U@vger.kernel.org
X-Gm-Message-State: AOJu0YzylWoyL6uzDEPrw3VSN3tJNxmx9xNUjBISwwTS5gGCQxTXN3LM
	C51h6jfJhtgxDbf+jRw2bMcPb20yguJ9W7iJ3cff6ibwnvhEPT0HwFLUHTDEy8aoJ/BX+TXfLN+
	9YhM884wdd91d63YjanhgYDTU1u9AjzNJKHxj
X-Gm-Gg: ASbGncsaGgmtbUaZqwpKDa8E2cGvvVaHktr+KMInYMNgXGVJVg0kK6L9SmNOhW9MgTk
	vozGDB3oTulMFwgyQ66cl/KlIMYA0tzjBp8roXromUKsQGoFjvD+EbDfPETwEURFBBP+/hBXant
	3kMCIc7D8OHvrJ5fvGcgAnKrT2vGGOOg==
X-Google-Smtp-Source: AGHT+IEj1HrgP+PRR64yxOZUY+DfSwtEqoT7Yuiu4KDug3Q8lx+H24sWHE2fgZDXyVsZuSpMdsxjQEadkTtzOQDKLAA=
X-Received: by 2002:a2e:9057:0:b0:309:24df:f193 with SMTP id
 38308e7fff4ca-30927b1df4dmr34510241fa.28.1739860090588; Mon, 17 Feb 2025
 22:28:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739437531.git.dvyukov@google.com> <Z6-F35N8fkhTvagn@tassilo>
In-Reply-To: <Z6-F35N8fkhTvagn@tassilo>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 18 Feb 2025 07:27:59 +0100
X-Gm-Features: AWEUYZnVw1t0MMI0uARYWXZ6L-6yww7k_T1niGFQKgDkplpLNw3FIa_MIGLD7VI
Message-ID: <CACT4Y+aWmc7fZuXKSVPj+dZ4DBOYHYHfCFq9fpmdKeD-QMsvPQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/9] perf report: Add latency and parallelism profiling
To: Andi Kleen <ak@linux.intel.com>
Cc: namhyung@kernel.org, irogers@google.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb 2025 at 19:05, Andi Kleen <ak@linux.intel.com> wrote:
>
> On Thu, Feb 13, 2025 at 10:08:13AM +0100, Dmitry Vyukov wrote:
> > There are two notions of time: wall-clock time and CPU time.
> > For a single-threaded program, or a program running on a single-core
> > machine, these notions are the same. However, for a multi-threaded/
> > multi-process program running on a multi-core machine, these notions are
> > significantly different. Each second of wall-clock time we have
> > number-of-cores seconds of CPU time.
>
> I read through it and it looks good to me.
>
> For the patchkit.
>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Thanks for the review!

Namhyung, Arnaldo, what's left for this series to be merged?
