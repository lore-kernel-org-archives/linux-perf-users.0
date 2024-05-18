Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCEE8F44;
	Sat, 18 May 2024 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716012875; cv=none; b=WHB/1//n9zEylrwF6g09M699KYxoGYmcH4T24LIAvQtCYqpVIbawn7v49c0/C0XTU1lcpq1M6BNxGoEjLg1Gj9PnmTLf3nazDeP5n12uDOEdJljnQtNKoeVQGmpIzmwWOETc37kqU6wsjdBLbMDk8aWRHtbqIDREcmj3Y/jb7nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716012875; c=relaxed/simple;
	bh=7AWQZ0E7xEqFD3ZduGzUbfk7ddpl4dqsvVPkuMElqg8=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=J0ybsolKnuAG9D+ieEOP5sxjspyng/D7AzerwIqXuDgRjFRTVp/Y4zPgbBv4BwngPpEcHIvA9PrNPXrVaO+dzmaSxfBlePFENkFpXyNjJYiyMI/R4fphfHd7iW8N2ydg5HQgAJtuMSQ4aHSwOZrViHqsNzGJWw8DoBla7C97gXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxherfRkhmgUkAAA--.1408S3;
	Sat, 18 May 2024 14:12:49 +0800 (CST)
Received: from [10.130.0.149] (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxTt7eRkhmj_QAAA--.5908S3;
	Sat, 18 May 2024 14:12:47 +0800 (CST)
To: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
From: Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Question about "perf list"
Message-ID: <4b101d3d-e216-0a43-30f3-19ef20c0522a@loongson.cn>
Date: Sat, 18 May 2024 14:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:AQAAf8CxTt7eRkhmj_QAAA--.5908S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr45JFWkGF4kKF47Ww47ZFc_yoW5AF45pF
	4rArn3tw4xXw4UJ34fAFn5ury3CryxCr1fK3WDAw4akFyFqFs0qFs2gr15Z3W5Kry5G3ya
	qa1j9r4ktrW8XFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
	AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
	4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
	UUU==

Hi all,

Please let me know whether it makes sense to do the following change,
if yes, I will post a formal patch after the merge window, thank you.

-- >8 --
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index 7b54e9385442..9fa15b32280f 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -67,11 +67,12 @@ void print_tracepoint_events(const struct 
print_callbacks *print_cb __maybe_unus
         struct dirent **sys_namelist = NULL;
         int sys_items;

-       put_tracing_file(events_path);
         if (events_fd < 0) {
                 pr_err("Error: failed to open tracing events directory\n");
+               pr_err("%s: %s\n", events_path, strerror(errno));
                 return;
         }
+       put_tracing_file(events_path);

         sys_items = tracing_events__scandir_alphasort(&sys_namelist);

Here are the motivations:

I met "Error: failed to open tracing events directory" twice when execute
"perf list", the first reason is there is no "/sys/kernel/tracing/events"
directory due to it does not enable the kernel tracing infrastructure
with CONFIG_FTRACE, the second reason is there is no root privileges, so
add the error string to tell the users what should to do, and also call
put_tracing_file() to free events_path a little later to avoid messy code
in the error message.

(1) Without CONFIG_FTRACE

   $ file /sys/kernel/tracing/events
   /sys/kernel/tracing/events: cannot open `/sys/kernel/tracing/events' 
(No such file or directory)
   # file /sys/kernel/tracing/events
   /sys/kernel/tracing/events: cannot open `/sys/kernel/tracing/events' 
(No such file or directory)


(2) With CONFIG_FTRACE but no root privileges

   $ file /sys/kernel/tracing/events
   /sys/kernel/tracing/events: cannot open `/sys/kernel/tracing/events' 
(Permission denied)
   # file /sys/kernel/tracing/events
   /sys/kernel/tracing/events: directory

Before:

   $ ./perf list
   Error: failed to open tracing events directory

After:

(1) Without CONFIG_FTRACE

   $ ./perf list
   Error: failed to open tracing events directory
   /sys/kernel/tracing//events: No such file or directory

(2) With CONFIG_FTRACE but no root privileges

   $ ./perf list
   Error: failed to open tracing events directory
   /sys/kernel/tracing//events: Permission denied

At the same time, maybe it needs to do the following tiny change
to avoid duplicate "/" in the file path.

-- >8 --
diff --git a/tools/lib/api/fs/tracing_path.c 
b/tools/lib/api/fs/tracing_path.c
index 30745f35d0d2..834fd64c7130 100644
--- a/tools/lib/api/fs/tracing_path.c
+++ b/tools/lib/api/fs/tracing_path.c
@@ -69,7 +69,7 @@ char *get_tracing_file(const char *name)
  {
         char *file;

-       if (asprintf(&file, "%s/%s", tracing_path_mount(), name) < 0)
+       if (asprintf(&file, "%s%s", tracing_path_mount(), name) < 0)
                 return NULL;

         return file;

Before:

   /sys/kernel/tracing//events

After:

   /sys/kernel/tracing/events

Thanks,
Tiezhu

