Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC3F31AF2C
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 02:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767580733; cv=none; b=bnZcEPWWA/vOPvNiJxxa5BGcAiF1gXTT+dE2ZYrHV9+G96tbYWPZXz3dKIYokKpQgCLj4+aNLYJiMjNMYW5ej8VPO4BYdB/GX7zkWdPWRVicQaaesKMTXlQmrLATLktV6HMBxbfZbmsp3KQnKnDVvjofLaiD1bgPwuVQ4bJtq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767580733; c=relaxed/simple;
	bh=7obfdYcAoY6c0ylCEFa7/4ZOtVj4bbzG2KYZukjLvQw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=FVtwkWY8WA6yZ+4UTd33UkMKOyNUuHdokSI1dYVVbRyX9y9xIT3KY/nvDwpsDC5Sux8GafeKBcaeEvS8m8o2Q3fFnda7h7zNXR8SSScpekMiqzP2sXUP/IqREBRpokeG4SokyBNwLoh0E8Mef9lLJkFl7Ipd3yi/1XzSSB0YQV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7c7599be25cso36641974a34.2
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jan 2026 18:38:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767580730; x=1768185530;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9o9u3BoEgfjkbS84MC31NTcI++PBXoKbiOR/3JRI8w=;
        b=FxMeGBRrzOzk2PVaMaAfKfdK9sZa4lojtluZSlYOmPOtSIuA0dGnPhunTfTTfwnbU+
         XjXMLvRO8dO08wTC1OHhf+2/fvcLFwY94P8XMoHoAv4loSE4GmULj7oWopQb12fRiklC
         7H7WGeq12vM6EEQ9hu6t9K1OBx4mRx32oCeoK15770WiOPV1F7S8fd5XXcmXoCU+MNa1
         lAkepDOv+SsXCOS51vfOvYE4f9atGO2oLEAlxCSLhQ6fvhKdcc9PC+M+PWWsvN8pGOwi
         TPXNP8ibQI5Hv+vxP2qZ1vGSIm42iEzVlSVQMbR8aFAaITeQEAIEN2O3Q9qLJ0DuORgK
         /mvg==
X-Forwarded-Encrypted: i=1; AJvYcCVttA5B1yqanMvqVR+hDb8KedCPkcwZMdCLh6QtO/MukXY2cdurDC8zjuGSGH5q+LyOO43yI/9r11VEBvxW8p6l@vger.kernel.org
X-Gm-Message-State: AOJu0YyOfVuXvNw1x5ajBHtQPagWD36DDm0r3RAPBcFilcW/Q3ovc/oM
	n/Plp5U/+dV+ViScK2/mWGtFW16pB8UWyABUZsb5Q/Gz7FZJU8iv59yTqE+RLnHsi5hAypgXqtG
	rtLF4fpnPUA8MxoAkjYBxcXnif9cQKa3EYchr8xFh4SfiApcBXJLJ7HQlQ1E=
X-Google-Smtp-Source: AGHT+IHxEiEyCDzK5u8kMXvWPaLqH2zQhGLy/7alfJTYSzUg1Py7KhmE0ECNV7JWJzl5OWCwqtrKIDwZJWXL81GYCFBoMgJyS+on
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:a094:b0:65d:757:39f6 with SMTP id
 006d021491bc7-65d0ea9d1aemr16413352eaf.39.1767580730260; Sun, 04 Jan 2026
 18:38:50 -0800 (PST)
Date: Sun, 04 Jan 2026 18:38:50 -0800
In-Reply-To: <20260105023842.1739283-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695b243a.050a0220.a1b6.0396.GAE@google.com>
Subject: Re: [syzbot] [perf?] KASAN: slab-use-after-free Read in __task_pid_nr_ns
From: syzbot <syzbot+e0378d4f4fe57aa2bdd0@syzkaller.appspotmail.com>
To: wangqing7171@gmail.com
Cc: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com, 
	namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, 
	syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

> #syz test

This crash does not have a reproducer. I cannot test it.

>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index b1f3915d5f8e..72b9b37a96c8 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1975,6 +1975,7 @@ __latent_entropy struct task_struct *copy_process(
>  	struct file *pidfile = NULL;
>  	const u64 clone_flags = args->flags;
>  	struct nsproxy *nsp = current->nsproxy;
> +	struct signal_struct *free_sig = NULL;
>  
>  	/*
>  	 * Don't allow sharing the root directory with processes in a different
> @@ -2501,8 +2502,11 @@ __latent_entropy struct task_struct *copy_process(
>  		mmput(p->mm);
>  	}
>  bad_fork_cleanup_signal:
> -	if (!(clone_flags & CLONE_THREAD))
> -		free_signal_struct(p->signal);
> +	if (!(clone_flags & CLONE_THREAD)) {
> +		free_sig = p->signal;
> +		p->signal = NULL;
> +		free_signal_struct(free_sig);
> +	}
>  bad_fork_cleanup_sighand:
>  	__cleanup_sighand(p->sighand);
>  bad_fork_cleanup_fs:
> diff --git a/kernel/pid.c b/kernel/pid.c
> index a31771bc89c1..1a012e033552 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -329,9 +329,9 @@ EXPORT_SYMBOL_GPL(find_vpid);
>  
>  static struct pid **task_pid_ptr(struct task_struct *task, enum pid_type type)
>  {
> -	return (type == PIDTYPE_PID) ?
> -		&task->thread_pid :
> -		&task->signal->pids[type];
> +	if (type == PIDTYPE_PID)
> +		return &task->thread_pid;
> +	return task->signal ? &task->signal->pids[type] : NULL;
>  }
>  
>  /*
> -- 
> 2.34.1
>
>
