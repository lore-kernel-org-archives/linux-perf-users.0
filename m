From: =?iso-2022-jp?B?GyRCSj8+PjJtTCYbKEIgLyBISVJBTUFUVRskQiEkGyhCTUFTQU1J?=
	<masami.hiramatsu.pt@hitachi.com>
Subject: RE: [PATCH perf/core 16/22] perf: Fix __cmd_top and
 perf_session__process_events to put the idle thread
Date: Thu, 10 Dec 2015 10:07:25 +0000
Message-ID: <50399556C9727B4D88A595C8584AAB375264F96D@GSjpTKYDCembx32.service.hitachi.net>
References: <20151209021047.10245.8918.stgit@localhost.localdomain>
 <20151209021122.10245.69707.stgit@localhost.localdomain>
 <20151209143019.GG15864@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151209143019.GG15864@kernel.org>
Content-Language: ja-JP
Sender: linux-kernel-owner@vger.kernel.org
To: 'Arnaldo Carvalho de Melo' <acme@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

>From: Arnaldo Carvalho de Melo [mailto:acme@kernel.org]
>
>Em Wed, Dec 09, 2015 at 11:11:23AM +0900, Masami Hiramatsu escreveu:
>> Since perf_session__register_idle_thread() got the idle thread,
>> caller functions have to put it afterwards.
>> Note that since the thread was already inserted to the session
>> list, it will be released when the session is released.
>> Also, in perf_session__register_idle_thread() failure path,
>> the thread should be put before returning.
>
>Wouldn't this be better by making perf_session__register_idle_thread()
>return -1 if it fails? I.e. that way its callers won't have to
>immediately put the idle thread, as they are doing nothing with it.
>

Ah, right. I thought that someone may use this return value, but no,
there is no code which use the returned thread.

>In the future, if someone needs a handle for that thread, a lookup can
>be done:
>
>  idle = machine__find_thread(&session->machines.host, 0, 0);
>
>I.e. this would be the resulting patch, please let me know if you are ok
>with this approach:

I'm OK for your approach :)

Reviewed-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>


Thanks!


>
>diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>index 7e2e72e6d9d1..f26b08e72f74 100644
>--- a/tools/perf/builtin-top.c
>+++ b/tools/perf/builtin-top.c
>@@ -964,7 +964,7 @@ static int __cmd_top(struct perf_top *top)
> 	if (ret)
> 		goto out_delete;
>
>-	if (perf_session__register_idle_thread(top->session) == NULL)
>+	if (perf_session__register_idle_thread(top->session) < 0)
> 		goto out_delete;
>
> 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
>diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>index c35ffdd360fe..9774686525b4 100644
>--- a/tools/perf/util/session.c
>+++ b/tools/perf/util/session.c
>@@ -1311,17 +1311,20 @@ struct thread *perf_session__findnew(struct perf_session *session, pid_t pid)
> 	return machine__findnew_thread(&session->machines.host, -1, pid);
> }
>
>-struct thread *perf_session__register_idle_thread(struct perf_session *session)
>+int perf_session__register_idle_thread(struct perf_session *session)
> {
> 	struct thread *thread;
>+	int err = 0;
>
> 	thread = machine__findnew_thread(&session->machines.host, 0, 0);
> 	if (thread == NULL || thread__set_comm(thread, "swapper", 0)) {
> 		pr_err("problem inserting idle task.\n");
>-		thread = NULL;
>+		err = -1;
> 	}
>
>-	return thread;
>+	/* machine__findnew_thread() got the thread, so put it */
>+	thread__put(thread);
>+	return err;
> }
>
> static void perf_session__warn_about_errors(const struct perf_session *session)
>@@ -1676,7 +1679,7 @@ int perf_session__process_events(struct perf_session *session)
> 	u64 size = perf_data_file__size(session->file);
> 	int err;
>
>-	if (perf_session__register_idle_thread(session) == NULL)
>+	if (perf_session__register_idle_thread(session) < 0)
> 		return -ENOMEM;
>
> 	if (!perf_data_file__is_pipe(session->file))
>diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
>index 3e900c0efc73..5f792e35d4c1 100644
>--- a/tools/perf/util/session.h
>+++ b/tools/perf/util/session.h
>@@ -89,7 +89,7 @@ struct machine *perf_session__findnew_machine(struct perf_session *session, pid_
> }
>
> struct thread *perf_session__findnew(struct perf_session *session, pid_t pid);
>-struct thread *perf_session__register_idle_thread(struct perf_session *session);
>+int perf_session__register_idle_thread(struct perf_session *session);
>
> size_t perf_session__fprintf(struct perf_session *session, FILE *fp);
>
