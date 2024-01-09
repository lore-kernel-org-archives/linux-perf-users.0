Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA625742
	for <linux-perf-users@vger.kernel.org>; Tue,  9 Jan 2024 22:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mj17uFDF"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d41bb4da91so17444435ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jan 2024 14:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704840953; x=1705445753; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFH7hTV+SWQOlddvGHiRMDX4NqO9BgeNhYdA1qYsDL8=;
        b=mj17uFDFR2j54nMvA66F78V4yGWgMF3wJuq+FK+D5EQA2xS/32Xu8+7RbQ2VNhJCtN
         8MfJjkU0JwA8f6bbvUd/Z/NOpE8+tE8VV5xGRloWyX6doBZegaV/awYhVosLnCOo7SVm
         FZYXyk5AzymlIV3Pn5MpRaHRLcLWrU1uG3kI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704840953; x=1705445753;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GFH7hTV+SWQOlddvGHiRMDX4NqO9BgeNhYdA1qYsDL8=;
        b=aWFJ6BVNFD+W2BhBIkdaEA4OmUmkTDjZfEdd5JukNPcj0fhVIuR33kMSAl+5AUed8D
         jzKzPpiuqaX5bMSLsoSvmlJ1oPnjiCRqcXQxf2Za5ecUw4jN9MiXcqQjISKSy7QScGb4
         hr07OPpa8kYe9FPr+dRZGu0twUBAmvJN8lR8ItlYXnoqw/YEnuKh4kISol0ajsQoDL67
         l3fqOLqOpPTfY8pkOhL8OZ2kMQKz1JyzBlIvBP8avb7q1vuepUmK2hqq4u0QgrkqB2Ee
         +Ud8d9zif0XfiyK7nfMv5k1XoJGqheHOX+pxsFrAPKH9zizKGe3rOa0TnbAEZNulK4I3
         cwvg==
X-Gm-Message-State: AOJu0YwoRMBj/RQ2ScDNcwhbSZKXVUvpamGV4QYsibTQj/2xhmyiN5CB
	rIdn3+zvjGB2nGhxMTNCLwPnOrAg/K3dmo67TkM29ZKsjQ==
X-Google-Smtp-Source: AGHT+IF3mck8ZHysDVdVQcaO4Frs9XRxJohjZ8M9N/QOpvp9AZu3qNkGUL5eiOm2KInVPlDcogKBUQ==
X-Received: by 2002:a17:903:40c9:b0:1d5:5bcc:f7fe with SMTP id t9-20020a17090340c900b001d55bccf7femr118886pld.48.1704840953196;
        Tue, 09 Jan 2024 14:55:53 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u5-20020a170903124500b001d4b685f82fsm2293015plh.165.2024.01.09.14.55.52
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:55:52 -0800 (PST)
Date: Tue, 9 Jan 2024 14:55:52 -0800
From: Kees Cook <keescook@chromium.org>
To: linux-perf-users@vger.kernel.org
Subject: Getting PMU stats on specific syscalls
Message-ID: <202401091452.B73E21B6C@keescook>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I'd like to get PMU stats only on specific syscalls. I haven't been able
to figure this out. i.e. how do I run:

	perf stat -e some_syscall_name_here make -j128

I can't figure out how to limit collection to only time spent during the
syscall I'm interested in. I tried building synthetic events, but that
doesn't seem to work...

Thanks!

-Kees

-- 
Kees Cook
