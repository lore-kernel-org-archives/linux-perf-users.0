From: Stephan Walter <walter@hlrs.de>
Subject: Perf stat suspend operation during profiling
Date: Mon, 13 Feb 2017 16:19:27 +0100
Message-ID: <d7fcdb14-13be-6580-5ec3-75230a3dbfea@hlrs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.hlrs.de ([141.58.2.50]:37973 "EHLO mail.hlrs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752181AbdBMPYh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Feb 2017 10:24:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.hlrs.de (Postfix) with ESMTP id 3E35396E
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2017 16:19:27 +0100 (CET)
Received: from mail.hlrs.de ([127.0.0.1])
        by localhost (mail.hlrs.de [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D3b_i6iL2f2V for <linux-perf-users@vger.kernel.org>;
        Mon, 13 Feb 2017 16:19:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.hlrs.de (Postfix) with ESMTP id 7D77510064
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2017 16:19:25 +0100 (CET)
Received: from mail.hlrs.de ([127.0.0.1])
        by localhost (mail.hlrs.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nuGOhGdoSaq9 for <linux-perf-users@vger.kernel.org>;
        Mon, 13 Feb 2017 16:19:25 +0100 (CET)
Received: from [141.58.5.87] (amtbrinkmann.hlrs.de [141.58.5.87])
        by mail.hlrs.de (Postfix) with ESMTPSA id 6ABDC96E
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Feb 2017 16:19:25 +0100 (CET)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I have used 'perf stat' to analyze a hybrid C++/FORTRAN MPI application, 
with the small wrapper at the end of this mail.

In general the profiling seems ok, beside that perf suspend the 
operating after 385 seconds and the restarts after 678 seconds. So there 
are nearly 300 seconds missing within the profile - I attached the 
corresponding part of the log file, where the problem occur. Any idea 
what is the cause for this behaviour and how I can avoid it, or is this 
a perf bug?

I tried to find within the archive an answer: 
http://dir.gmane.org/gmane.linux.kernel.perf.user

But the archive seems to be not available.

Thank you very much for your help.

Best regards,

Stephan

#########
#Log file
#########
385.748547983,CPU0,5.26,MiB,uncore_imc_1/cas_count_write/,508898897,100.00
385.748547983,CPU12,4.70,MiB,uncore_imc_1/cas_count_write/,508899025,100.00
385.748547983,CPU0,542296054,,uncore_imc_1/clockticks/,508899034,100.00
385.748547983,CPU12,542296279,,uncore_imc_1/clockticks/,508899210,100.00
385.748547983,CPU0,484.28,MiB,uncore_imc_4/cas_count_read/,508899126,100.00
385.748547983,CPU12,774.55,MiB,uncore_imc_4/cas_count_read/,508898882,100.00
385.748547983,CPU0,3.67,MiB,uncore_imc_4/cas_count_write/,508898990,100.00
385.748547983,CPU12,3.05,MiB,uncore_imc_4/cas_count_write/,508898941,100.00
385.748547983,CPU0,542295652,,uncore_imc_4/clockticks/,508898640,100.00
385.748547983,CPU12,542295605,,uncore_imc_4/clockticks/,508898699,100.00
385.748547983,CPU0,486.01,MiB,uncore_imc_5/cas_count_read/,508898532,100.00
385.748547983,CPU12,776.21,MiB,uncore_imc_5/cas_count_read/,508898610,100.00
385.748547983,CPU0,5.29,MiB,uncore_imc_5/cas_count_write/,508898458,100.00
385.748547983,CPU12,4.73,MiB,uncore_imc_5/cas_count_write/,508898425,100.00
385.748547983,CPU0,542295472,,uncore_imc_5/clockticks/,508898490,100.00
385.748547983,CPU12,542295396,,uncore_imc_5/clockticks/,508898478,100.00
678.029749442,CPU0,331163689852,,instructions,292576368267,100.00
    678.029749442,CPU1,199462127,,instructions,292576343345,100.00
678.029749442,CPU2,1233581060942,,instructions,292576342461,100.00
678.029749442,CPU3,816611787893,,instructions,292576342977,100.00
    678.029749442,CPU4,132073035,,instructions,292576320473,100.00
678.029749442,CPU5,400984990376,,instructions,292576337863,100.00
    678.029749442,CPU6,42094190,,instructions,292576313383,100.00
    678.029749442,CPU7,53892483,,instructions,292576316092,100.00
    678.029749442,CPU8,115688888,,instructions,292576293790,100.00



###############
#perf-mpi-wrapper.sh
###############
#!/bin/bash

sample_intervall=500

CPU_counter="instructions,cpu-cycles,branch-misses,LLC-loads,LLC-stores"
SOFTWARE_counter="context-switches,cpu-migrations,minor-faults"
UNCORE_counter0="uncore_imc_0/cas_count_read/,uncore_imc_0/cas_count_write/,uncore_imc_0/clockticks/"
UNCORE_counter1="uncore_imc_1/cas_count_read/,uncore_imc_1/cas_count_write/,uncore_imc_1/clockticks/"
UNCORE_counter2="uncore_imc_4/cas_count_read/,uncore_imc_4/cas_count_write/,uncore_imc_4/clockticks/"
UNCORE_counter3="uncore_imc_5/cas_count_read/,uncore_imc_5/cas_count_write/,uncore_imc_5/clockticks/"


if [ "$OMPI_COMM_WORLD_RANK" == "0" ]
then
         OUT_DIR="./PERF$(date +%s)"
         OUT_FILE="./${OUT_DIR}/events.log"
         mkdir $OUT_DIR
         PERF_CL="perf stat -I $sample_intervall -e 
${CPU_counter},${SOFTWARE_counter},${UNCORE_counter0},${UNCORE_counter1},${UNCORE_counter2},${UNCORE_counter3} 
-a -A -x , -o ${OUT_FILE} &"
eval $PERF_CL
         PID_PERF=$!
         $* &
else
         $* &
fi

echo $PERF_CL

##get the process id of the launched process
PID_CF=$!
while true
do
         if kill -0 $PID_CF 2> /dev/null
         then
                 sleep 60
         else
                 echo "Rank $OMPI_COMM_WORLD_RANK finished: $($date)"
                 if [ "$OMPI_COMM_WORLD_RANK" == "0" ]
                 then
                         kill -INT $PID_PERF
                 fi
                 break
         fi
done
