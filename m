Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0961F72605
	for <linux-perf-users@vger.kernel.org>; Thu, 15 May 2025 00:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747269748; cv=none; b=Eid/aYncsT61mxxkOebtyNJpODzADcljby1ZBL9eXKR5bAjRXbEVqjUWrINnqgt4DxNNq0IvfMsbvn0zEi5q3kKjXaQlP/F739jxV55S8c/4vE4UEyCc/uwtT5NW8wdsnuxewE+2I66lc+DJstCv1uQCQp3LJwtOqEOd5HDSASA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747269748; c=relaxed/simple;
	bh=obx/PLZ6UIcwrs7uFv57ytnLd/749bN6ofjc/xYVY9g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C5m74ydgnOvXN6kf8vmntlKglrF3c1PtsaxY+BY99kNKzLsiGEUc7HncDKMfHjP9lOenOKaoYbkKeWRIBzfNZ49QA99VezE3/E5iJF/BV39toCdFmwluX9ZoVSqvAw5RuhhiwA1olSt5H4YwD2gicvYkWC1nJeO0U1JRdcN14Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qp/SqBWx; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qp/SqBWx"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-741a845cab2so540764b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 14 May 2025 17:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747269746; x=1747874546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lXQTySoZYBcx+77niflWXedrq2Xx/F460KNE+k8S/c=;
        b=qp/SqBWxOXq/Ic61hIJ+Z2ASMpBiyG38ziHJr//11C9+8FIFMYXXoO7jmvjPMvXRtR
         hxRsMVWXUg2IR9VOz1y0uykkNqKZ1VWP4jx+aEQasvNty/XBTlAIwynyQDhPCk7oN1RX
         gOc/SCbznUMRZdnWs44UZCpka4oV93npH4tFk6EDep6pqR2KHA5JBhAdajHGySRNlh12
         3Y62DjsngLvFKV02aRdLdGQTU0jMxKm4Pu210x0AT761Ev6Ad9RhOujCFNA/GvijiZkf
         hTJCCuCfiK4FMWX1X3b+T8ue9/Ka5n3PCxDahl6t3rr6zmJszNWvzm+GuWF53lYcONj/
         vICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747269746; x=1747874546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7lXQTySoZYBcx+77niflWXedrq2Xx/F460KNE+k8S/c=;
        b=HW/Tv9/8W33g2H7TPazZl7SNSs4fiUh2jbF8G96c7wN/G9/EEUPrAy3fQA71VwGAZx
         5ucGdRTrefOAZvHZAmt4UWv1zqL8kRfp32fmEHasLphkhbOjvNF6Q2CtxjkFMPOymUhI
         v/hEkwpKakHzmmmeSUrFoYm/5b+i/2uYq0V68qrG4YAZ5ajk1LGjyjKYllwJG/RQ5WKi
         XSVGA1lKFUR/DgiduQJehUpq9EkoTfYkKspph76wstgxNdiN3bOvu2ycTKwrJJ9KULmo
         6fIvf6VsIOljkBJa3vd9d109adodG4PV8gSTQrPLJNlEOwtc3GXA+2dlwC/Tfe4aZb7B
         ukQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtxm/opBH0jtMUKJfwzHnsIg9ZSP2DU73iSnzW31HO7UPXnt2LE5om07drbnlYlb9u/Lt6jGVyO6LnJbTeujVj@vger.kernel.org
X-Gm-Message-State: AOJu0YxsdzJkcC4yPP5/AO4ZWDCJ6rZErRTbts7Jz3fo/K/SQAqzRWYo
	XJaEhg1nYrfKgHbkEx4kkEG1NuhWTqHgWmz78adFBFYOQxuXyfxYOi3huOy1BtSvNK2oLAuAkLF
	yaA==
X-Google-Smtp-Source: AGHT+IGqxLXceYPydbCzXDD6iL7DFmjD1CvfNfOZAnmDRwybRZ8Dhg2v8MOu1RtV/6HVzmq7qJop18AXyQc=
X-Received: from pfwz36.prod.google.com ([2002:a05:6a00:1da4:b0:736:5ca8:c79a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1897:b0:736:53f2:87bc
 with SMTP id d2e1a72fcca58-742984f64d9mr965977b3a.13.1747269746181; Wed, 14
 May 2025 17:42:26 -0700 (PDT)
Date: Wed, 14 May 2025 17:42:24 -0700
In-Reply-To: <20250324173121.1275209-27-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-27-mizhang@google.com>
Message-ID: <aCU4cHtvjwDordxW@google.com>
Subject: Re: [PATCH v4 26/38] KVM: x86/pmu: Introduce eventsel_hw to prepare
 for pmu event filtering
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> -	pmu->fixed_ctr_ctrl = pmu->global_ctrl = pmu->global_status = 0;
> +	pmu->fixed_ctr_ctrl = pmu->fixed_ctr_ctrl_hw = 0;
> +	pmu->global_ctrl = pmu->global_status = 0;

VMCS needs to be updated.
