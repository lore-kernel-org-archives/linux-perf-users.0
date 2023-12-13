Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="SzZPap/1"
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE65E8
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Dec 2023 06:54:16 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-77f35009e78so408709885a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Dec 2023 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1702479255; x=1703084055; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYhZKTO+n/Hy770LjqTnEQ/mbZOGO/ntqNbsrj+NvGk=;
        b=SzZPap/1VBkTdxomNGlMOzALXK62v3vANuZSl5XzIoYOLak5aJbE3cdTSmiHYjcE+Q
         JFd8eIHTrXRzO2OY7HHeqP1XL8zjNegG7RWAFah/+bECQlpUVfv9cksKW6yIAz54KWc5
         yB/zo9usXOvw0CKeHlpaBSaMIJcYtaS+p3XqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479255; x=1703084055;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYhZKTO+n/Hy770LjqTnEQ/mbZOGO/ntqNbsrj+NvGk=;
        b=Nkgf+qKpybdnuDzPkbPGrzeG1gbI2X+78VHYsRPoF8gy/9nmitZXJf2rq45JRw0RDm
         crQ1vR8pym/gz3KoYeD+SXbWkYcFR8fAOqvtDhUER1Fg/NczPNofzCD7XnMRKRIVr0GE
         DzMFtK4DuniBZiS66a1H0Gfw0X7BcNdxVS3vAr5hxtQT93zsJOQvaAqnOfw8JZgx1k4x
         gLcE70WhBOjiLkSLbSboaE3M3ibXhKJ8TCb0CW79PS7zLvGTLlH0cRbiCkUv3pLVRwKl
         n0n1zNL8tRO7xRf9cnetai2lZh76X5yxBSnDPS0s7p8HvUqjp6NwekrlUnTLJio7HdGk
         JIEw==
X-Gm-Message-State: AOJu0YxtgipvhMGx6aAGE+79ooy4pjupBDTxjzdv7p7C6Vrq07vEl7cK
	hp58w32ODdCIy4H7JRiZHDAzSw==
X-Google-Smtp-Source: AGHT+IH0o9dvc/q99ZcvvS/TE42YBHUKs3xa0xzfNMF3FDuCvAzTxzCANGs7FzeNBNzX67Oh34TgTQ==
X-Received: by 2002:a05:620a:4496:b0:77f:8c7a:8a94 with SMTP id x22-20020a05620a449600b0077f8c7a8a94mr3011201qkp.72.1702479255429;
        Wed, 13 Dec 2023 06:54:15 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id re19-20020a05620a8e1300b0077f13650cb7sm4556860qkn.2.2023.12.13.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:54:15 -0800 (PST)
From: Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date: Wed, 13 Dec 2023 09:54:09 -0500 (EST)
To: xingwei lee <xrivendell7@gmail.com>
cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
    mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
    namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
    linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in down_trylock/perf_event_open
In-Reply-To: <CABOYnLxoG=YsE1XyOjfF0O+2UrdTyK1JMir3xPapGsRzh-XFAA@mail.gmail.com>
Message-ID: <227eb61b-8068-001e-47fa-b65104b3b226@maine.edu>
References: <CABOYnLxoG=YsE1XyOjfF0O+2UrdTyK1JMir3xPapGsRzh-XFAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 11 Dec 2023, xingwei lee wrote:

> Hello I found a bug in kernel/perf in the lastest upstream linux 6.7.rc5
> possible deadlock in down_trylock/perf_event_open
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei Lee <xrivendell7@gmail.com>
> 

> 
> syzkaller login: root
> Linux syzkaller 6.7.0-rc5 #3 SMP PREEMPT_DYNAMIC Mon Dec 11 17:02:24
> HKT 2023 x86_64
> root@syzkaller:~# ./572
> [  113.795108][ T8266] ------------[ cut here ]------------
> [  113.795707][ T8266] WARNING: CPU: 1 PID: 8266 at
> kernel/events/core.c:1950 __do_sys_perf_event_open0


Just wanted to add that the perf_fuzzer will trigger this warning more or 
less immediately as well.

Vince
